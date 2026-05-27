#!/bin/sh

set -eu

display="${DDCUTIL_DISPLAY:-1}"
signal=10

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

        while read -r val; do
            # Drain buffered values so we only apply the latest one.
            # read -t 0 only checks availability without consuming; use a small
            # positive timeout so the read actually drains the data.
            while read -r -t 0.1 next; do val="$next"; done
            set_brightness "$val" "$max"
        done < <(yad --scale --value="$pct" --min=1 --max=100 \
            --step=5 --print-partial --hide-value --no-buttons --title='monitor_brightness_slider')
        ;;
esac
