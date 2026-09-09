#!/bin/sh

set -u

temperature="${NIGHT_LIGHT_TEMPERATURE:-4500}"
runtime_dir="${XDG_RUNTIME_DIR:-/tmp}"
pid_file="${runtime_dir}/waybar-night-light-${UID:-$(id -u)}.pid"
signal=12

night_light_pid() {
    [ -r "$pid_file" ] || return 1

    pid=$(cat "$pid_file")
    case "$pid" in
        ''|*[!0-9]*) return 1 ;;
    esac

    [ -r "/proc/$pid/comm" ] || return 1
    [ "$(cat "/proc/$pid/comm")" = "gammastep" ] || return 1
    kill -0 "$pid" 2>/dev/null || return 1

    printf '%s\n' "$pid"
}

refresh_waybar() {
    pkill -RTMIN+"$signal" waybar 2>/dev/null || true
}

case "${1:-status}" in
    toggle)
        if pid=$(night_light_pid); then
            kill "$pid" 2>/dev/null || true
            rm -f "$pid_file"
        elif command -v gammastep >/dev/null 2>&1; then
            # Gammastep must stay alive on Wayland to retain its gamma ramp.
            # Identical day/night values make this a manual, constant setting.
            gammastep -m wayland -l 0:0 -t "$temperature:$temperature" -r \
                >/dev/null 2>&1 &
            new_pid=$!
            if ! printf '%s\n' "$new_pid" > "$pid_file"; then
                kill "$new_pid" 2>/dev/null || true
                wait "$new_pid" 2>/dev/null || true
                exit 1
            fi
        fi
        refresh_waybar
        ;;
    status)
        if ! command -v gammastep >/dev/null 2>&1; then
            printf '{"text":"󰖔","alt":"unavailable","tooltip":"Night light unavailable (gammastep is not installed)","class":"unavailable"}\n'
        elif night_light_pid >/dev/null; then
            printf '{"text":"󰖔","alt":"on","tooltip":"Night light ON (%s K) — click to disable","class":"on"}\n' "$temperature"
        else
            rm -f "$pid_file"
            printf '{"text":"󰖙","alt":"off","tooltip":"Night light OFF — click to enable (%s K)","class":"off"}\n' "$temperature"
        fi
        ;;
    *)
        printf 'Usage: %s [status|toggle]\n' "$0" >&2
        exit 2
        ;;
esac
