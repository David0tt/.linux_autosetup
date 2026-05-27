#!/bin/sh

set -eu

display="${DDCUTIL_DISPLAY:-1}"
step="${DDCUTIL_BRIGHTNESS_STEP:-5}"
signal="${WAYBAR_BRIGHTNESS_SIGNAL:-10}"

get_brightness() {
    ddcutil --display "$display" getvcp 10 --brief | awk '{ print $(NF-1), $NF }'
}

refresh_waybar() {
    pkill -RTMIN+"$signal" waybar >/dev/null 2>&1 || true
}

get_brightness_percent() {
    set -- $(get_brightness)
    current="$1"
    maximum="$2"

    if [ "$maximum" -le 0 ]; then
        maximum=100
    fi

    echo $(( current * 100 / maximum ))
}

set_brightness_percent() {
    target_percent="$1"
    set -- $(get_brightness)
    maximum="$2"

    if [ "$maximum" -le 0 ]; then
        maximum=100
    fi

    if [ "$target_percent" -lt 1 ]; then
        target_percent=1
    fi

    if [ "$target_percent" -gt 100 ]; then
        target_percent=100
    fi

    target_value=$(( (target_percent * maximum + 50) / 100 ))

    if [ "$target_value" -lt 1 ]; then
        target_value=1
    fi

    ddcutil --display "$display" setvcp 10 "$target_value" >/dev/null
    refresh_waybar
}

print_status() {
    percentage=$(get_brightness_percent)
    tooltip=$(printf 'Brightness: %s%%' "$percentage")

    printf '{"text":"%s%%","tooltip":"%s","percentage":%s}\n' "$percentage" "$tooltip" "$percentage"
}

open_popup() {
    percentage=$(get_brightness_percent)

    zenity --scale \
        --text='Monitor brightness' \
        --value="$percentage" \
        --min-value=1 \
        --max-value=100 \
        --step="$step" \
        --print-partial \
        --hide-value | {
            last_value=''
            while IFS= read -r value; do
                case "$value" in
                    ''|*[!0-9]*)
                        continue
                        ;;
                esac

                if [ "$value" = "$last_value" ]; then
                    continue
                fi

                last_value="$value"
                set_brightness_percent "$value"
            done
        }
}

case "${1:-status}" in
    status)
        print_status
        ;;
    popup)
        open_popup
        ;;
    *)
        echo "Usage: $0 [status|popup]" >&2
        exit 1
        ;;
esac