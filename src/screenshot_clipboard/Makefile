PREFIX ?= $(HOME)/.local
CC ?= cc

PROTOCOL_XML := /usr/share/wayland-protocols/staging/ext-data-control/ext-data-control-v1.xml
BUILD_DIR := build
PROTOCOL_HEADER := $(BUILD_DIR)/ext-data-control-v1-client-protocol.h
PROTOCOL_CODE := $(BUILD_DIR)/ext-data-control-v1-protocol.c
TARGET := screenshot-clipboard

CFLAGS += -std=c11 -O2 -Wall -Wextra -Wpedantic
CPPFLAGS += -D_GNU_SOURCE -I$(BUILD_DIR) $(shell pkg-config --cflags wayland-client)
LDLIBS += $(shell pkg-config --libs wayland-client)

.PHONY: all clean install

all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $@

$(PROTOCOL_HEADER): $(PROTOCOL_XML) | $(BUILD_DIR)
	wayland-scanner client-header $< $@

$(PROTOCOL_CODE): $(PROTOCOL_XML) | $(BUILD_DIR)
	wayland-scanner private-code $< $@

$(TARGET): screenshot_clipboard.c $(PROTOCOL_HEADER) $(PROTOCOL_CODE)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ screenshot_clipboard.c $(PROTOCOL_CODE) $(LDLIBS)

install: $(TARGET)
	install -D -m 755 $(TARGET) $(DESTDIR)$(PREFIX)/bin/$(TARGET)

clean:
	rm -rf $(BUILD_DIR) $(TARGET)
