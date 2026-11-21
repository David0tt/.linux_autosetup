#!/bin/sh

# Use stable device names rather than sink indices, which change on reconnect.
set -eu

fail() {
    printf '%s\n' "$1" >&2
    if command -v notify-send >/dev/null 2>&1; then
        notify-send -u normal 'Audio output' "$1" || true
    fi
    exit 1
}

status_json() {
    jq -cn --arg text "$1" --arg tooltip "$2" --arg class "$3" \
        '{text: $text, tooltip: $tooltip, class: $class}'
}

action=${1:-status}
case "$action" in
    status) ;;
    toggle)
        # Ignore overlapping clicks; refresh every bar immediately afterwards.
        exec 9>"${XDG_RUNTIME_DIR:-/tmp}/waybar-audio-output-$(id -u).lock"
        flock -xn 9 || exit 0
        trap 'pkill -u "$(id -u)" -x -RTMIN+13 waybar 2>/dev/null || true' 0
        ;;
    *) printf 'Usage: %s [status|toggle]\n' "$0" >&2; exit 2 ;;
esac

if ! sinks=$(pactl -f json list sinks 2>/dev/null) ||
   ! current=$(pactl get-default-sink 2>/dev/null); then
    if [ "$action" = toggle ]; then
        fail 'Cannot connect to the audio service.'
    fi
    status_json '󰅶' 'Audio service unavailable' unavailable
    exit 0
fi

fiio=$(printf '%s' "$sinks" | jq -r '
    [.[] | select(.name | startswith("alsa_output.usb-GuangZhou_FiiO_Electronics_Co._Ltd_FiiO_K7-")) | .name][0] // empty')
boom=$(printf '%s' "$sinks" | jq -r '
    [.[] | select(.name | startswith("bluez_output.10_94_97_08_F0_92.")) | .name][0] // empty')

if [ -n "$fiio" ] && [ "$current" = "$fiio" ]; then
    text='    K7'
    label='FiiO K7'
    class=fiio
    target=$boom
    target_label='Boom 3'
elif [ -n "$boom" ] && [ "$current" = "$boom" ]; then
    text='󰓃  Boom 3'
    label='Boom 3'
    class=boom
    target=$fiio
    target_label='FiiO K7'
else
    text='󰕾 Other'
    label=$(printf '%s' "$sinks" | jq -r --arg current "$current" \
        '[.[] | select(.name == $current) | .description][0] // $current')
    class=other
    target=$fiio
    target_label='FiiO K7'
    if [ -z "$target" ]; then
        target=$boom
        target_label='Boom 3'
    fi
fi

if [ "$action" = status ]; then
    if [ -n "$target" ]; then
        tooltip="Output: $label — click to switch all playback to $target_label"
    else
        tooltip="Output: $label — $target_label is not connected"
        class=unavailable
    fi
    status_json "$text" "$tooltip" "$class"
    exit 0
fi

[ -n "$target" ] || fail "$target_label is not connected. Connect it in Bluetooth/audio controls first."
pactl set-default-sink "$target" || fail "Could not set $target_label as the default output."

# Move existing playback too, including apps explicitly routed to another sink.
inputs=$(pactl -f json list sink-inputs) || fail 'Could not list active playback streams.'
failed=0
for input in $(printf '%s' "$inputs" | jq -r '.[].index'); do
    if ! pactl move-sink-input "$input" "$target"; then
        # A stream may disappear naturally while switching (e.g. a short sound).
        if remaining=$(pactl -f json list sink-inputs) &&
           ! printf '%s' "$remaining" | jq -e --argjson index "$input" \
               'any(.[]; .index == $index)' >/dev/null; then
            continue
        fi
        failed=1
    fi
done
[ "$failed" -eq 0 ] || fail "Default changed to $target_label, but some playback streams could not be moved."
