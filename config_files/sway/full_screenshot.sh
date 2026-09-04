#!/usr/bin/env bash

set -euo pipefail

screenshot_dir="${XDG_CACHE_HOME:-${HOME}/.cache}/screenshots"
screenshot_path="${screenshot_dir}/latest.png"
clipboard_helper="${HOME}/.local/bin/screenshot-clipboard"
capture_mode="${1:-full}"

mkdir -p -- "${screenshot_dir}"

if [[ ! -x "${clipboard_helper}" ]]; then
    notify-send \
        --urgency=critical \
        --app-name="Screenshot" \
        "Screenshot failed" \
        "Clipboard helper is not installed at ${clipboard_helper}"
    exit 1
fi

case "${capture_mode}" in
    full)
        capture_command=(grim "${screenshot_path}")
        ;;
    region)
        # Cancelling the selection is intentional; keep the clipboard intact.
        if ! geometry="$(slurp)" || [[ -z "${geometry}" ]]; then
            exit 0
        fi
        capture_command=(grim -g "${geometry}" "${screenshot_path}")
        ;;
    *)
        printf 'Usage: %s [full|region]\n' "${0}" >&2
        exit 2
        ;;
esac

if ! "${capture_command[@]}"; then
    notify-send \
        --urgency=critical \
        --app-name="Screenshot" \
        "Screenshot failed" \
        "The screenshot could not be captured"
    exit 1
fi

if ! "${clipboard_helper}" "${screenshot_path}"; then
    notify-send \
        --urgency=critical \
        --app-name="Screenshot" \
        "Screenshot failed" \
        "The capture could not be copied to the clipboard"
    exit 1
fi

notify-send \
    --app-name="Screenshot" \
    --expire-time=5000 \
    --icon="${screenshot_path}" \
    "Screenshot captured"
