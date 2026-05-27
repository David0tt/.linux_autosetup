#!/usr/bin/env bash
set -euo pipefail

MSG_BIN="${MSG_BIN:-swaymsg}"
WATCH_SCRIPT="${WATCH_SCRIPT:-$HOME/.config/sway/popup_on_focus_loss.sh}"
LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/popup_on_focus_loss_daemon.lock"

APP_ID_RE='^(nm-connection-editor|blueman-manager|org\.pulseaudio\.pavucontrol|pavucontrol)$'
CLASS_RE='^(Nm-connection-editor|Blueman-manager|Pavucontrol)$'
TITLE_RE='^(Network Connections|Bluetooth.*|Volume Control)$'

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "$1 is required" >&2
    exit 69
  }
}

matches_popup() {
  jq -e \
    --arg app_id_re "$APP_ID_RE" \
    --arg class_re "$CLASS_RE" \
    --arg title_re "$TITLE_RE" '
      def match_re($value; $pattern):
        (($value // "") | tostring | test($pattern));

      (.container // {}) as $con
      | (match_re($con.app_id; $app_id_re)
        or match_re($con.window_properties.class; $class_re)
        or match_re($con.name; $title_re))
    ' >/dev/null
}

require_cmd "$MSG_BIN"
require_cmd jq
require_cmd "$WATCH_SCRIPT"
require_cmd flock

exec 9>"$LOCK_FILE"
flock -n 9 || exit 0

declare -A watcher_pids=()

while IFS= read -r event; do
  change="$(jq -r '.change // empty' <<<"$event")"
  [[ "$change" == "new" || "$change" == "title" ]] || continue

  matches_popup <<<"$event" || continue

  con_id="$(jq -r '.container.id // empty' <<<"$event")"
  [[ -n "$con_id" ]] || continue

  existing_pid="${watcher_pids[$con_id]:-}"
  if [[ -n "$existing_pid" ]] && kill -0 "$existing_pid" 2>/dev/null; then
    continue
  fi

  "$WATCH_SCRIPT" --con-id "$con_id" >/dev/null 2>&1 &
  watcher_pids[$con_id]=$!
done < <("$MSG_BIN" -m -t subscribe '["window"]')