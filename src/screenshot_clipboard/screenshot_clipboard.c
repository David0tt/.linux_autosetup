/*
 * Publish one PNG as image data and as a copied-file reference.
 *
 * This uses ext-data-control-v1, the clipboard-control protocol supported by
 * Sway. Unlike toolkit clipboard APIs, it does not need a window or an input
 * event serial, and unlike wl-copy it can advertise multiple MIME types.
 */

#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <wayland-client.h>

#include "ext-data-control-v1-client-protocol.h"

struct context {
    struct wl_display *display;
    struct wl_seat *seat;
    struct ext_data_control_manager_v1 *manager;
    struct ext_data_control_device_v1 *device;
    struct ext_data_control_source_v1 *source;
    struct ext_data_control_offer_v1 *selection_offer;
    struct ext_data_control_offer_v1 *primary_offer;

    unsigned char *png;
    size_t png_size;
    char *uri;
    bool cancelled;
};

static int write_all(int fd, const void *data, size_t size)
{
    const unsigned char *cursor = data;

    while (size > 0) {
        ssize_t written = write(fd, cursor, size);
        if (written < 0) {
            if (errno == EINTR)
                continue;
            return -1;
        }
        cursor += (size_t)written;
        size -= (size_t)written;
    }

    return 0;
}

static int read_png(const char *path, unsigned char **data, size_t *size)
{
    int fd = open(path, O_RDONLY | O_CLOEXEC);
    if (fd < 0)
        return -1;

    struct stat info;
    if (fstat(fd, &info) < 0 || info.st_size < 0) {
        close(fd);
        return -1;
    }

    size_t length = (size_t)info.st_size;
    unsigned char *buffer = malloc(length == 0 ? 1 : length);
    if (buffer == NULL) {
        close(fd);
        errno = ENOMEM;
        return -1;
    }

    size_t offset = 0;
    while (offset < length) {
        ssize_t count = read(fd, buffer + offset, length - offset);
        if (count < 0) {
            if (errno == EINTR)
                continue;
            free(buffer);
            close(fd);
            return -1;
        }
        if (count == 0)
            break;
        offset += (size_t)count;
    }
    close(fd);

    if (offset != length) {
        free(buffer);
        errno = EIO;
        return -1;
    }

    *data = buffer;
    *size = length;
    return 0;
}

static bool uri_path_character(unsigned char character)
{
    return (character >= 'a' && character <= 'z') ||
           (character >= 'A' && character <= 'Z') ||
           (character >= '0' && character <= '9') ||
           character == '-' || character == '.' || character == '_' ||
           character == '~' || character == '/';
}

static char *file_uri(const char *path)
{
    static const char hex[] = "0123456789ABCDEF";
    size_t path_length = strlen(path);
    size_t capacity = strlen("file://") + path_length * 3 + 1;
    char *uri = malloc(capacity);
    if (uri == NULL)
        return NULL;

    char *output = uri;
    memcpy(output, "file://", strlen("file://"));
    output += strlen("file://");

    for (size_t index = 0; index < path_length; ++index) {
        unsigned char character = (unsigned char)path[index];
        if (uri_path_character(character)) {
            *output++ = (char)character;
        } else {
            *output++ = '%';
            *output++ = hex[character >> 4];
            *output++ = hex[character & 0x0f];
        }
    }
    *output = '\0';
    return uri;
}

static void send_payload(void *data,
                         struct ext_data_control_source_v1 *source,
                         const char *mime_type,
                         int32_t fd)
{
    (void)source;
    struct context *context = data;

    if (strcmp(mime_type, "image/png") == 0) {
        (void)write_all(fd, context->png, context->png_size);
    } else if (strcmp(mime_type, "text/uri-list") == 0) {
        (void)write_all(fd, context->uri, strlen(context->uri));
        (void)write_all(fd, "\r\n", 2);
    } else if (strcmp(mime_type, "x-special/gnome-copied-files") == 0) {
        (void)write_all(fd, "copy\n", 5);
        (void)write_all(fd, context->uri, strlen(context->uri));
        (void)write_all(fd, "\n", 1);
    } else if (strcmp(mime_type, "application/x-kde-cutselection") == 0) {
        /* KDE uses 0 for copy and 1 for cut. */
        (void)write_all(fd, "0", 1);
    }

    close(fd);
}

static void source_cancelled(void *data,
                             struct ext_data_control_source_v1 *source)
{
    (void)source;
    ((struct context *)data)->cancelled = true;
}

static const struct ext_data_control_source_v1_listener source_listener = {
    .send = send_payload,
    .cancelled = source_cancelled,
};

static void offered_mime(void *data,
                         struct ext_data_control_offer_v1 *offer,
                         const char *mime_type)
{
    (void)data;
    (void)offer;
    (void)mime_type;
}

static const struct ext_data_control_offer_v1_listener offer_listener = {
    .offer = offered_mime,
};

static void new_offer(void *data,
                      struct ext_data_control_device_v1 *device,
                      struct ext_data_control_offer_v1 *offer)
{
    (void)data;
    (void)device;
    ext_data_control_offer_v1_add_listener(offer, &offer_listener, NULL);
}

static void selection_changed(void *data,
                              struct ext_data_control_device_v1 *device,
                              struct ext_data_control_offer_v1 *offer)
{
    (void)device;
    struct context *context = data;
    if (context->selection_offer != NULL &&
        context->selection_offer != offer)
        ext_data_control_offer_v1_destroy(context->selection_offer);
    context->selection_offer = offer;
}

static void device_finished(void *data,
                            struct ext_data_control_device_v1 *device)
{
    (void)device;
    ((struct context *)data)->cancelled = true;
}

static void primary_changed(void *data,
                            struct ext_data_control_device_v1 *device,
                            struct ext_data_control_offer_v1 *offer)
{
    (void)device;
    struct context *context = data;
    if (context->primary_offer != NULL && context->primary_offer != offer)
        ext_data_control_offer_v1_destroy(context->primary_offer);
    context->primary_offer = offer;
}

static const struct ext_data_control_device_v1_listener device_listener = {
    .data_offer = new_offer,
    .selection = selection_changed,
    .finished = device_finished,
    .primary_selection = primary_changed,
};

static void registry_global(void *data,
                            struct wl_registry *registry,
                            uint32_t name,
                            const char *interface,
                            uint32_t version)
{
    (void)version;
    struct context *context = data;

    if (strcmp(interface, wl_seat_interface.name) == 0 &&
        context->seat == NULL) {
        context->seat = wl_registry_bind(
            registry, name, &wl_seat_interface, 1);
    } else if (strcmp(interface, ext_data_control_manager_v1_interface.name) == 0) {
        context->manager = wl_registry_bind(
            registry, name, &ext_data_control_manager_v1_interface, 1);
    }
}

static void registry_global_remove(void *data,
                                   struct wl_registry *registry,
                                   uint32_t name)
{
    (void)data;
    (void)registry;
    (void)name;
}

static const struct wl_registry_listener registry_listener = {
    .global = registry_global,
    .global_remove = registry_global_remove,
};

static int publish(struct context *context)
{
    context->display = wl_display_connect(NULL);
    if (context->display == NULL) {
        fprintf(stderr, "screenshot-clipboard: cannot connect to Wayland\n");
        return -1;
    }

    struct wl_registry *registry = wl_display_get_registry(context->display);
    wl_registry_add_listener(registry, &registry_listener, context);
    if (wl_display_roundtrip(context->display) < 0)
        return -1;

    if (context->seat == NULL || context->manager == NULL) {
        fprintf(stderr,
                "screenshot-clipboard: Sway does not expose ext-data-control-v1\n");
        return -1;
    }

    context->device = ext_data_control_manager_v1_get_data_device(
        context->manager, context->seat);
    ext_data_control_device_v1_add_listener(
        context->device, &device_listener, context);

    /* Consume the initial selection event before replacing it. */
    if (wl_display_roundtrip(context->display) < 0)
        return -1;

    context->source = ext_data_control_manager_v1_create_data_source(
        context->manager);
    ext_data_control_source_v1_add_listener(
        context->source, &source_listener, context);
    ext_data_control_source_v1_offer(context->source, "image/png");
    ext_data_control_source_v1_offer(context->source, "text/uri-list");
    ext_data_control_source_v1_offer(
        context->source, "x-special/gnome-copied-files");
    ext_data_control_source_v1_offer(
        context->source, "application/x-kde-cutselection");
    ext_data_control_device_v1_set_selection(context->device, context->source);

    if (wl_display_roundtrip(context->display) < 0 || context->cancelled)
        return -1;

    return 0;
}

int main(int argc, char **argv)
{
    if (argc != 2) {
        fprintf(stderr, "Usage: %s PNG_FILE\n", argv[0]);
        return 2;
    }

    signal(SIGPIPE, SIG_IGN);

    char *absolute_path = realpath(argv[1], NULL);
    if (absolute_path == NULL) {
        fprintf(stderr, "%s: %s\n", argv[1], strerror(errno));
        return 1;
    }

    struct context context = {0};
    context.uri = file_uri(absolute_path);
    if (context.uri == NULL ||
        read_png(absolute_path, &context.png, &context.png_size) < 0) {
        fprintf(stderr, "%s: %s\n", absolute_path, strerror(errno));
        free(absolute_path);
        free(context.uri);
        return 1;
    }
    free(absolute_path);

    if (publish(&context) < 0)
        return 1;

    pid_t child = fork();
    if (child < 0) {
        fprintf(stderr, "screenshot-clipboard: fork: %s\n", strerror(errno));
        return 1;
    }
    if (child > 0)
        return 0;

    (void)setsid();
    while (!context.cancelled && wl_display_dispatch(context.display) >= 0) {
    }

    return 0;
}
