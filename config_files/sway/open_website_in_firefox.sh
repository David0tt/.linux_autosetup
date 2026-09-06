#!/usr/bin/env bash
set -euo pipefail

MSG_BIN="${MSG_BIN:-swaymsg}"
URL=""
WS=""
WORKSPACE_EXPLICIT=false

usage() {
  echo "Usage: $(basename "$0") [--workspace NUMBER] <url>" >&2
}

while (( $# > 0 )); do
  case "$1" in
    --workspace)
      if (( $# < 2 )); then
        echo "--workspace requires a number" >&2
        usage
        exit 64
      fi
      WS="$2"
      WORKSPACE_EXPLICIT=true
      shift 2
      ;;
    --workspace=*)
      WS="${1#*=}"
      WORKSPACE_EXPLICIT=true
      shift
      ;;
    --)
      shift
      if (( $# != 1 )) || [[ -n "$URL" ]]; then
        usage
        exit 64
      fi
      URL="$1"
      shift
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      exit 64
      ;;
    *)
      if [[ -n "$URL" ]]; then
        usage
        exit 64
      fi
      URL="$1"
      shift
      ;;
  esac
done

if [[ -z "$URL" ]]; then
  usage
  exit 64
fi

if $WORKSPACE_EXPLICIT && [[ ! "$WS" =~ ^[1-9][0-9]*$ ]]; then
  echo "--workspace must be a positive integer" >&2
  exit 64
fi

command -v "$MSG_BIN" >/dev/null || {
  echo "$MSG_BIN is required" >&2
  exit 69
}
command -v jq >/dev/null || {
  echo "jq is required" >&2
  exit 69
}

# Without --workspace, target whichever workspace is currently focused.
if ! $WORKSPACE_EXPLICIT; then
  WS=$("$MSG_BIN" -t get_workspaces | jq -r '.[] | select(.focused == true) | .name // empty')
  if [[ -z "$WS" ]]; then
    echo "Could not determine the currently focused workspace" >&2
    exit 69
  fi
fi


# Print the container id of a Firefox window on the workspace, if present.
get_firefox_con_id_in_ws() {
  local ws="$1"
  "$MSG_BIN" -t get_tree | jq -r --arg ws "$ws" '
    def nodes: .nodes? // empty + .floating_nodes? // empty;
    def descend: recurse(nodes[]);
    def is_target_workspace:
      (.type == "workspace") and (($ws | tonumber? // null) as $n |
        if $n != null then .num == $n else (.name // "") == $ws end
      );
    def is_firefox:
      [
        (.app_id // ""),
        (.window_properties.class // ""),
        (.window_properties.instance // "")
      ]
      | map(tostring | ascii_downcase)
      | any(.[]; contains("firefox"));
    first(
      descend
      | select(is_target_workspace)
      | descend
      | select((.window != null or .app_id != null) and is_firefox)
      | .id
    ) // empty
  '
}


# Return 0 if the currently focused workspace matches $1.
focused_ws_is() {
  local ws="$1"
  "$MSG_BIN" -t get_workspaces | jq -e --arg ws "$ws" '
    any(.[]; .focused == true and (($ws | tonumber? // null) as $n |
      if $n != null then .num == $n else (.name // "") == $ws end
    ))
  ' >/dev/null
}

# Return 0 if currently focused container is a Firefox window
focused_is_firefox() {
  "$MSG_BIN" -t get_tree | jq -e '
    def nodes: .nodes? // empty + .floating_nodes? // empty;
    def descend: recurse(nodes[]);
    descend
    | select(.focused == true)
    | [
        (.app_id // ""),
        (.window_properties.class // ""),
        (.window_properties.instance // "")
      ]
    | map(tostring | ascii_downcase)
    | any(.[]; contains("firefox"))
  ' >/dev/null
}

# Switch workspaces only when the caller explicitly requested one.
focus_target_workspace() {
  if $WORKSPACE_EXPLICIT; then
    "$MSG_BIN" -q "workspace number ${WS}" >/dev/null
  fi
}

# Fast-path: if Firefox is already focused on the target workspace, just open a new tab
if focused_ws_is "$WS" && focused_is_firefox; then
  nohup firefox --new-tab "$URL" >/dev/null 2>&1 &
  exit 0
fi

firefox_con_id="$(get_firefox_con_id_in_ws "$WS")"

# If Firefox is already on the target workspace, focus it and open in a new tab.
# Otherwise, switch to the workspace and start Firefox there with the URL.
if [[ -n "$firefox_con_id" ]]; then
  # Focus the workspace and a Firefox window there first so the remote new-tab targets it.
  focus_target_workspace
  "$MSG_BIN" -q "[con_id=${firefox_con_id}] focus" >/dev/null
  # Open the URL in a new tab of the running instance
  sleep 0.1 # small sleep to ensure focus has taken effect
  nohup firefox --new-tab "$URL" >/dev/null 2>&1 &
else
  # Switch if requested, then launch Firefox with the URL on the target workspace.
  focus_target_workspace
  # Quote the URL inside the sway command to avoid shell interpretation of & and ?
  printf -v qurl '%q' "$URL"
  "$MSG_BIN" -q "exec firefox --new-window ${qurl}" >/dev/null
fi
