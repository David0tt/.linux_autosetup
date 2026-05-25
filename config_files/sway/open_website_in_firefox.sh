#!/usr/bin/env bash
set -euo pipefail

WS="9"
URL="${1-}"
MSG_BIN="${MSG_BIN:-swaymsg}"

# Require one URL argument
if [[ -z "${URL}" ]]; then
  echo "Usage: $(basename "$0") <url>" >&2
  exit 64
fi

# Return 0 if matching window exists in the workspace
# Return 1 if no match.
# Return 2 if jq is missing.
command -v "$MSG_BIN" >/dev/null || {
  echo "$MSG_BIN is required" >&2
  exit 69
}


# Print the container id of a Firefox window on the workspace, if present.
get_firefox_con_id_in_ws() {
  local ws="$1"
  command -v jq >/dev/null || { echo "jq is required" >&2; return 2; }
  "$MSG_BIN" -t get_tree | jq -r --arg ws "$ws" '
    def nodes: .nodes? // empty + .floating_nodes? // empty;
    def descend: recurse(nodes[]);
    def is_target_workspace:
      (.type == "workspace") and (
        (.name // "" | tostring | startswith($ws)) or
        (($ws | tonumber?) as $n | ($n != null and .num == $n))
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


# Return 0 if the currently focused workspace matches $1 (number match or name prefix)
focused_ws_is() {
  local ws="$1"
  command -v jq >/dev/null || return 1
  local name
  name=$("$MSG_BIN" -t get_workspaces | jq -r '.[] | select(.focused==true) | .name // empty') || return 1
  [[ -n "$name" ]] || return 1
  if [[ "$name" == "$ws"* ]]; then
    return 0
  fi
  if [[ "$ws" =~ ^[0-9]+$ && "$name" == "$ws" ]]; then
    return 0
  fi
  return 1
}

# Return 0 if currently focused container is a Firefox window
focused_is_firefox() {
  command -v jq >/dev/null || return 1
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
  "$MSG_BIN" -q "workspace number ${WS}" >/dev/null
  "$MSG_BIN" -q "[con_id=${firefox_con_id}] focus" >/dev/null
  # Open the URL in a new tab of the running instance
  sleep 0.1 # small sleep to ensure focus has taken effect
  nohup firefox --new-tab "$URL" >/dev/null 2>&1 &
else
  # Ensure we are on the correct workspace and launch Firefox with the URL there.
  "$MSG_BIN" -q "workspace number ${WS}" >/dev/null
  # Quote the URL inside the sway command to avoid shell interpretation of & and ?
  printf -v qurl '%q' "$URL"
  "$MSG_BIN" -q "exec firefox --new-window ${qurl}" >/dev/null
fi


