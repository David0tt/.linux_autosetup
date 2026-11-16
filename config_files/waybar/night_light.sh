#!/bin/sh

set -u

temperature="${NIGHT_LIGHT_TEMPERATURE:-4500}"
runtime_dir="${XDG_RUNTIME_DIR:-/tmp}"
wayland_display="${WAYLAND_DISPLAY:-wayland-0}"
user_id=$(id -u)
session_id=$(printf '%s' "$runtime_dir/$wayland_display" | cksum | cut -d ' ' -f 1)
state_prefix="$runtime_dir/waybar-night-light-$user_id-$session_id"
log_file="$state_prefix.log"

# Match our command and desktop session, including instances with lost PID files.
night_light_pids() {
    for pid in $(pgrep -u "$user_id" -x gammastep); do
        process_env=$(tr '\0' '\n' 2>/dev/null < "/proc/$pid/environ") || continue
        printf '%s\n' "$process_env" | grep -Fxq "WAYLAND_DISPLAY=$wayland_display" || continue
        printf '%s\n' "$process_env" | grep -Fxq "XDG_RUNTIME_DIR=$runtime_dir" || continue
        grep -q '^State:.*Z' "/proc/$pid/status" 2>/dev/null && continue

        # Gammastep replaces option colons with NULs after startup.
        tr '\0' ' ' 2>/dev/null < "/proc/$pid/cmdline" | grep -Eq \
            '^([^ ]*/)?gammastep -m wayland -l 0[: ]0 -t [0-9]+[: ][0-9]+ -r $' || continue
        printf '%s\n' "$pid"
    done
}

wait_for_state() {
    remaining=$2
    while [ "$remaining" -gt 0 ]; do
        state=off
        [ -n "$(night_light_pids)" ] && state=on
        [ "$state" = "$1" ] && return 0
        remaining=$((remaining - 1))
        sleep 0.02
    done
    return 1
}

# Drop overlapping clicks; let status reads wait for the result.
umask 077
exec 9>"$state_prefix.lock"
if [ "${1:-status}" = toggle ]; then
    flock -xn 9 || exit 0
    trap 'pkill -u "$user_id" -x -RTMIN+12 waybar 2>/dev/null || true' 0
else
    flock -x 9 || exit 1
fi

case "${1:-status}" in
    toggle)
        pids=$(night_light_pids)
        if [ -n "$pids" ]; then
            for pid in $pids; do
                kill "$pid" 2>/dev/null || true
            done
            wait_for_state off 150 || {
                printf 'Night light did not stop; its processes are still running.\n' >&2
                exit 1
            }
            rm -f "$log_file"
        elif command -v gammastep >/dev/null 2>&1; then
            # Keep a constant temperature; close the lock in the daemon.
            XDG_RUNTIME_DIR="$runtime_dir" WAYLAND_DISPLAY="$wayland_display" \
                gammastep -m wayland -l 0:0 -t "$temperature:$temperature" -r \
                >"$log_file" 2>&1 9>&- &
            new_pid=$!
            # Confirm startup and catch immediate setup failures.
            wait_for_state on 50 && sleep 0.02
            if ! night_light_pids | grep -Fxq "$new_pid"; then
                kill "$new_pid" 2>/dev/null || true
                wait "$new_pid" 2>/dev/null || true
                printf 'Night light failed to start.\n' >> "$log_file"
                cat "$log_file" >&2
                exit 1
            fi
        fi
        ;;
    status)
        if ! command -v gammastep >/dev/null 2>&1; then
            printf '{"text":"󰖔","alt":"unavailable","tooltip":"Night light unavailable (gammastep is not installed)","class":"unavailable"}\n'
        elif [ -n "$(night_light_pids)" ]; then
            printf '{"text":"󰖔","alt":"on","tooltip":"Night light ON (%s K) — click to disable","class":"on"}\n' "$temperature"
        elif [ -s "$log_file" ]; then
            printf '{"text":"󰖔","alt":"error","tooltip":"Night light failed to start — click to retry","class":"unavailable"}\n'
        else
            printf '{"text":"󰖙","alt":"off","tooltip":"Night light OFF — click to enable (%s K)","class":"off"}\n' "$temperature"
        fi
        ;;
    *)
        printf 'Usage: %s [status|toggle]\n' "$0" >&2
        exit 2
        ;;
esac
