#!/bin/sh

set -eu

display="${DDCUTIL_DISPLAY:-1}"
signal="${WAYBAR_BRIGHTNESS_SIGNAL:-10}"
target_file="/tmp/brightness_$(id -u)"

# Helper to avoid repetitive ddcutil calls when sliding
set_brightness() {
    # $1: percentage, $2: max_value
    target=$(( ($1 * $2 + 50) / 100 ))
    ddcutil --display "$display" setvcp 10 "$target" --noverify >/dev/null 2>&1
    pkill -RTMIN+"$signal" waybar 2>/dev/null || true
}

case "${1:-status}" in
    status)
        # Brief output format: VCP 10 CND <current_value> <max_value>
        set -- $(ddcutil --display "$display" getvcp 10 --brief)
        current=$4 max=$5
        pct=$(( current * 100 / max ))
        printf '{"text":"%s%%","tooltip":"Brightness: %s%%","percentage":%s}\n' "$pct" "$pct" "$pct"
        ;;
    popup)
        set -- $(ddcutil --display "$display" getvcp 10 --brief)
        max=$5
        pct=$(( $4 * 100 / max ))

        zenity --scale --text='Monitor brightness' --value="$pct" --min-value=1 --max-value=100 \
            --step="${DDCUTIL_BRIGHTNESS_STEP:-5}" --print-partial --hide-value | while read -r val; do
            echo "$val" > "$target_file"
            # Start worker if not already running to consume the latest target
            if ! pgrep -f "monitor_brightness.sh _worker" > /dev/null; then
                "$0" _worker "$max" &
            fi
        done
        ;;
    _worker)
        max="$2"
        # Consume target_file while it exists and has content
        while [ -s "$target_file" ]; do
            val=$(cat "$target_file")
            # Clear file to signal we've read the latest
            : > "$target_file" 
            set_brightness "$val" "$max"
            # If nothing new was written during ddcutil call, we can exit
            if ! [ -s "$target_file" ]; then
                rm -f "$target_file"
            fi
        done
        ;;
esac
