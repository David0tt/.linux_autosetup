#!/bin/sh

# Check if any output has HDR enabled
# Note: In Sway 1.12, the 'hdr' property in JSON is a boolean.

if [ "${1:-}" = "toggle" ]; then
    # Toggle HDR for all outputs
    swaymsg -t get_outputs | jq -r '.[] | .name' | xargs -I {} swaymsg "output {} hdr toggle" >/dev/null 2>&1
    # Reload waybar to fix layer-shell input corruption after HDR output reconfiguration.
    pkill waybar
    waybar
    # Refresh waybar module state (is now not needed since waybar is already reloaded now)
    # pkill -RTMIN+11 waybar 2>/dev/null || true

    exit 0
else
    hdr_active=$(swaymsg -t get_outputs | jq 'any(.[]; .hdr == true)')
    if [ "$hdr_active" = "true" ]; then
        # HDR is on
        printf '{"text":"󰵽", "alt":"on", "tooltip":"HDR is currently ENABLED", "class":"on"}\n'
    else
        # HDR is off
        printf '{"text":"󰵾", "alt":"off", "tooltip":"HDR is currently DISABLED", "class":"off"}\n'
    fi
fi



