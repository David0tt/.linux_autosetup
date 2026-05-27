#!/usr/bin/env bash
set -euo pipefail

MSG_BIN="${MSG_BIN:-swaymsg}"
START_TIMEOUT="${START_TIMEOUT:-5}"
LOCK_FILE="${XDG_RUNTIME_DIR:-/tmp}/popup_on_focus_loss_daemon.lock"
DAEMON_MODE=0

DAEMON_APP_ID_RE='^(nm-connection-editor|blueman-manager|org\.pulseaudio\.pavucontrol|pavucontrol)$'
DAEMON_CLASS_RE='^(Nm-connection-editor|Blueman-manager|Pavucontrol)$'
DAEMON_TITLE_RE='^(Network Connections|Bluetooth.*|Volume Control)$'

DIRECT_CON_ID=""
APP_ID_RE=""
CLASS_RE=""
INSTANCE_RE=""
TITLE_RE=""

usage() {
  cat <<'EOF'
Usage:
  popup_on_focus_loss.sh --daemon
  popup_on_focus_loss.sh [match options] -- command [args...]
  popup_on_focus_loss.sh --con-id ID

This system can be used to automatically close an application on focus loss.
This can be useful, for example for "pop-up" applications in the system bar, 
e.g. audio or bluetooth settings. 

Launch a command, attach to an existing Sway container, or run a daemon that
watches for matching popup windows and kills them after they lose focus.

Match options:
  --daemon            Watch for matching popup windows and attach automatically
  --con-id ID         Attach to an existing container instead of launching one
  --app-id REGEX     Match container app_id
  --class REGEX      Match Xwayland window class
  --instance REGEX   Match Xwayland window instance
  --title REGEX      Match container title/name
  --timeout SECONDS  Wait time for the window to appear (default: 5)
  --help             Show this help

Examples:
  popup_on_focus_loss.sh --daemon
  popup_on_focus_loss.sh --con-id 123456789
  popup_on_focus_loss.sh --app-id '^pavucontrol$' --class '^Pavucontrol$' -- pavucontrol
  popup_on_focus_loss.sh --app-id '^nm-connection-editor$' --title '^Network Connections$' -- nm-connection-editor
EOF
}

die() {
  echo "$*" >&2
  exit 64
}

require_value() {
  [[ $# -ge 2 ]] || die "Missing value for $1"
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "$1 is required" >&2
    exit 69
  }
}

tree_json() {
  "$MSG_BIN" -t get_tree
}

matching_containers() {
  tree_json | jq -c \
    --arg app_id_re "$APP_ID_RE" \
    --arg class_re "$CLASS_RE" \
    --arg instance_re "$INSTANCE_RE" \
    --arg title_re "$TITLE_RE" '
      def kids: (.nodes // []) + (.floating_nodes // []);
      def walk: recurse(kids[]?);
      def match_re($value; $pattern):
        ($pattern == "") or (($value // "") | tostring | test($pattern));

      walk
      | select((.type == "con") or (.type == "floating_con"))
      | select(match_re(.app_id; $app_id_re))
      | select(match_re(.window_properties.class; $class_re))
      | select(match_re(.window_properties.instance; $instance_re))
      | select(match_re(.name; $title_re))
    '
}

list_matching_ids() {
  matching_containers | jq -r '.id'
}

find_con_id_by_pid() {
  local pid="$1"
  tree_json | jq -r --argjson pid "$pid" '
    def kids: (.nodes // []) + (.floating_nodes // []);
    def walk: recurse(kids[]?);

    first(
      walk
      | select((.type == "con") or (.type == "floating_con"))
      | select(.pid == $pid)
      | .id
    ) // empty
  '
}

find_con_id_by_criteria() {
  local before_ids="${1:-}"
  local after_ids
  local focused_id
  local id

  after_ids="$(list_matching_ids)"

  if [[ -n "$before_ids" ]]; then
    while IFS= read -r id; do
      [[ -n "$id" ]] || continue
      if ! grep -Fqx "$id" <<<"$before_ids"; then
        printf '%s\n' "$id"
        return 0
      fi
    done <<<"$after_ids"
  fi

  focused_id="$(matching_containers | jq -r 'select(.focused == true) | .id' | head -n 1)"

  if [[ -n "$focused_id" ]]; then
    printf '%s\n' "$focused_id"
    return 0
  fi

  printf '%s\n' "$after_ids" | head -n 1
}

container_state() {
  local con_id="$1"
  tree_json | jq -c --argjson con_id "$con_id" '
    def kids: (.nodes // []) + (.floating_nodes // []);
    def walk: recurse(kids[]?);

    first(walk | select(.id == $con_id) | {exists: true, focused: (.focused // false)})
    // {exists: false, focused: false}
  '
}

kill_container() {
  local con_id="$1"
  "$MSG_BIN" -q "[con_id=${con_id}] kill" >/dev/null 2>&1 || true
}

has_criteria() {
  [[ -n "$APP_ID_RE" || -n "$CLASS_RE" || -n "$INSTANCE_RE" || -n "$TITLE_RE" ]]
}

resolve_con_id() {
  local con_id="$DIRECT_CON_ID"
  local before_ids=""
  local deadline

  if [[ -n "$con_id" ]]; then
    printf '%s\n' "$con_id"
    return 0
  fi

  if has_criteria; then
    before_ids="$(list_matching_ids || true)"
  fi

  "$@" &
  local app_pid=$!
  deadline=$((SECONDS + START_TIMEOUT))

  while (( SECONDS < deadline )); do
    if kill -0 "$app_pid" 2>/dev/null; then
      con_id="$(find_con_id_by_pid "$app_pid")"
    fi

    if [[ -z "$con_id" ]] && has_criteria; then
      con_id="$(find_con_id_by_criteria "$before_ids")"
    fi

    [[ -n "$con_id" ]] && break
    sleep 0.1
  done

  printf '%s\n' "$con_id"
}

run_daemon() {
  require_cmd flock

  exec 9>"$LOCK_FILE"
  flock -n 9 || exit 0

  declare -A watcher_pids=()
  local event con_id

  while IFS= read -r event; do
    con_id="$(jq -re \
      --arg app_id_re "$DAEMON_APP_ID_RE" \
      --arg class_re "$DAEMON_CLASS_RE" \
      --arg title_re "$DAEMON_TITLE_RE" '
      def match_re($v; $p): (($v // "") | tostring | test($p));
      select(.change == "new" or .change == "title")
      | (.container // {}) as $c
      | select(
          match_re($c.app_id; $app_id_re) or
          match_re($c.window_properties.class; $class_re) or
          match_re($c.name; $title_re)
        )
      | $c.id // empty | tostring
    ' <<<"$event")" || continue

    [[ -n "${watcher_pids[$con_id]:-}" ]] && kill -0 "${watcher_pids[$con_id]}" 2>/dev/null && continue

    "$0" --con-id "$con_id" >/dev/null 2>&1 &
    watcher_pids[$con_id]=$!
  done < <("$MSG_BIN" -m -t subscribe '["window"]')
}

watch_con_id() {
  local con_id="$1"
  local seen_focused=0
  local state

  state="$(container_state "$con_id")"
  jq -e '.focused == true' >/dev/null <<<"$state" && seen_focused=1

  while IFS= read -r _line; do
    state="$(container_state "$con_id")"

    if jq -e '.exists == false' >/dev/null <<<"$state"; then
      exit 0
    fi

    if jq -e '.focused == true' >/dev/null <<<"$state"; then
      seen_focused=1
      continue
    fi

    if (( seen_focused )); then
      kill_container "$con_id"
      exit 0
    fi
  done < <("$MSG_BIN" -m -t subscribe '["window","workspace"]')
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --daemon)
      DAEMON_MODE=1
      shift
      ;;
    --con-id)
      require_value "$@"
      DIRECT_CON_ID="$2"
      shift 2
      ;;
    --app-id)
      require_value "$@"
      APP_ID_RE="$2"
      shift 2
      ;;
    --class)
      require_value "$@"
      CLASS_RE="$2"
      shift 2
      ;;
    --instance)
      require_value "$@"
      INSTANCE_RE="$2"
      shift 2
      ;;
    --title)
      require_value "$@"
      TITLE_RE="$2"
      shift 2
      ;;
    --timeout)
      require_value "$@"
      START_TIMEOUT="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 64
      ;;
  esac
done

if (( ! DAEMON_MODE )) && [[ -z "$DIRECT_CON_ID" && $# -eq 0 ]]; then
  usage >&2
  exit 64
fi

require_cmd "$MSG_BIN"
require_cmd jq

if (( DAEMON_MODE )); then
  run_daemon
  exit 0
fi

con_id="$(resolve_con_id "$@")"

if [[ -z "$con_id" ]]; then
  echo "Unable to resolve a Sway container for: $*" >&2
  exit 1
fi

watch_con_id "$con_id"