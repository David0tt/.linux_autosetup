#!/bin/sh

# Check if any output has HDR enabled
# Note: In Sway 1.12, the 'hdr' property in JSON is a boolean.
hdr_active=$(swaymsg -t get_outputs | jq 'any(.[]; .hdr == true)')

if [ "${1:-}" = "toggle" ]; then
    # Toggle HDR for all outputs
    swaymsg -t get_outputs | jq -r '.[] | .name' | xargs -I {} swaymsg "output {} hdr toggle" >/dev/null 2>&1
    # Refresh waybar (if needed)
    pkill -RTMIN+11 waybar 2>/dev/null || true
    exit 0
fi

if [ "$hdr_active" = "true" ]; then
    # HDR is on
    printf '{"text":"󰵽", "alt":"on", "tooltip":"HDR is currently ENABLED", "class":"on"}\n'
else
    # HDR is off
    printf '{"text":"󰵾", "alt":"off", "tooltip":"HDR is currently DISABLED", "class":"off"}\n'
fi

