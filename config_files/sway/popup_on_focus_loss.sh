#!/usr/bin/env bash
set -euo pipefail

MSG_BIN="${MSG_BIN:-swaymsg}"
START_TIMEOUT="${START_TIMEOUT:-5}"

APP_ID_RE=""
CLASS_RE=""
INSTANCE_RE=""
TITLE_RE=""

usage() {
  cat <<'EOF'
Usage:
  popup_on_focus_loss.sh [match options] -- command [args...]

Launch a command, resolve the corresponding Sway container, and kill it after it
has been focused once and then loses focus.

Match options:
  --app-id REGEX     Match container app_id
  --class REGEX      Match Xwayland window class
  --instance REGEX   Match Xwayland window instance
  --title REGEX      Match container title/name
  --timeout SECONDS  Wait time for the window to appear (default: 5)
  --help             Show this help

Examples:
  popup_on_focus_loss.sh --app-id '^pavucontrol$' --class '^Pavucontrol$' -- pavucontrol
  popup_on_focus_loss.sh --app-id '^nm-connection-editor$' --title '^Network Connections$' -- nm-connection-editor
EOF
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

list_matching_ids() {
  tree_json | jq -r \
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
      | .id
    '
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

  focused_id="$(tree_json | jq -r \
    --arg app_id_re "$APP_ID_RE" \
    --arg class_re "$CLASS_RE" \
    --arg instance_re "$INSTANCE_RE" \
    --arg title_re "$TITLE_RE" '
      def kids: (.nodes // []) + (.floating_nodes // []);
      def walk: recurse(kids[]?);
      def match_re($value; $pattern):
        ($pattern == "") or (($value // "") | tostring | test($pattern));

      first(
        walk
        | select((.type == "con") or (.type == "floating_con"))
        | select(match_re(.app_id; $app_id_re))
        | select(match_re(.window_properties.class; $class_re))
        | select(match_re(.window_properties.instance; $instance_re))
        | select(match_re(.name; $title_re))
        | select(.focused == true)
        | .id
      ) // empty
    ')"

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

while [[ $# -gt 0 ]]; do
  case "$1" in
    --app-id)
      APP_ID_RE="$2"
      shift 2
      ;;
    --class)
      CLASS_RE="$2"
      shift 2
      ;;
    --instance)
      INSTANCE_RE="$2"
      shift 2
      ;;
    --title)
      TITLE_RE="$2"
      shift 2
      ;;
    --timeout)
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

[[ $# -gt 0 ]] || {
  usage >&2
  exit 64
}

require_cmd "$MSG_BIN"
require_cmd jq

before_ids=""
if has_criteria; then
  before_ids="$(list_matching_ids || true)"
fi

"$@" &
app_pid=$!

deadline=$((SECONDS + START_TIMEOUT))
con_id=""

while (( SECONDS < deadline )); do
  if kill -0 "$app_pid" 2>/dev/null; then
    con_id="$(find_con_id_by_pid "$app_pid")"
  fi

  if [[ -z "$con_id" ]] && has_criteria; then
    con_id="$(find_con_id_by_criteria "$before_ids")"
  fi

  if [[ -n "$con_id" ]]; then
    break
  fi

  sleep 0.1
done

if [[ -z "$con_id" ]]; then
  echo "Unable to resolve a Sway container for: $*" >&2
  exit 1
fi

seen_focused=0
state="$(container_state "$con_id")"
if jq -e '.focused == true' >/dev/null <<<"$state"; then
  seen_focused=1
fi

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