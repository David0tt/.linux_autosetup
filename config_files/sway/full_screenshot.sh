#!/usr/bin/env bash

set -euo pipefail

screenshot_dir="${XDG_CACHE_HOME:-${HOME}/.cache}/screenshots"
screenshot_path="${screenshot_dir}/latest.png"
clipboard_mode="${1:-file}"

mkdir -p -- "${screenshot_dir}"

if grim "${screenshot_path}"; then
    case "${clipboard_mode}" in
        file)
            # File managers expect a copied-file reference, not raw PNG bytes.
            printf 'copy\nfile://%s\n' "${screenshot_path}" \
                | wl-copy --type x-special/gnome-copied-files
            notification_body="Full desktop copied as a file"
            ;;
        image)
            wl-copy --type image/png < "${screenshot_path}"
            notification_body="Full desktop copied as image data"
            ;;
        *)
            printf 'Usage: %s [file|image]\n' "${0}" >&2
            exit 2
            ;;
    esac

    notify-send \
        --app-name="Screenshot" \
        --expire-time=5000 \
        --icon="${screenshot_path}" \
        "Screenshot captured" \
        "${notification_body}"
else
    notify-send \
        --urgency=critical \
        --app-name="Screenshot" \
        "Screenshot failed" \
        "The full desktop could not be captured"
    exit 1
fi
