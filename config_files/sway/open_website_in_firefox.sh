#!/usr/bin/env bash
set -euo pipefail

WS="9"
URL="${1-}"

# Require one URL argument
if [[ -z "${URL}" ]]; then
  echo "Usage: $(basename "$0") <url>" >&2
  exit 64
fi


# Return 0 if a matching window exists in the workspace.
# Return 1 if no match.
# Return 2 if jq is missing.
check_in_ws() {
  local ws="$1" cls="$2"
  command -v jq >/dev/null || { echo "jq is required" >&2; return 2; }
  i3-msg -t get_tree | jq -e --arg ws "$ws" --arg cls "$cls" '
    def nodes: .nodes? // empty + .floating_nodes? // empty;
    def descend: recurse(nodes[]);
    ($cls | ascii_downcase) as $needle
    | any(
        # match workspace by number or name prefix (so "8" matches "8: web")
        (descend | select(.type=="workspace" and (
           (.name // "" | tostring | startswith($ws)) or
           (($ws|tonumber?) as $n | ($n != null and .num == $n))
        )));
        # within that workspace, any window whose title/class/instance contains $needle (case-insensitive)
        any(
          (. | descend | select(.window != null));
          (
            ((.name // "" | tostring | ascii_downcase)       ) as $title
            | ((.window_properties.class    // "" | tostring | ascii_downcase) ) as $class
            | ((.window_properties.instance // "" | tostring | ascii_downcase) ) as $inst
            | [$title, $class, $inst] | any(.[]; contains($needle))
          )
        )
      )
  ' >/dev/null
}


# Return 0 if the currently focused workspace matches $1 (number match or name prefix)
focused_ws_is() {
  local ws="$1"
  command -v jq >/dev/null || return 1
  local name
  name=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name // empty') || return 1
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
  i3-msg -t get_tree | jq -e '
    def nodes: .nodes? // empty + .floating_nodes? // empty;
    def descend: recurse(nodes[]);
    (descend | select(.focused==true) | .window_properties.class? // "" | ascii_downcase) | contains("firefox")
  ' >/dev/null
}

# Fast-path: if Firefox is already focused on the target workspace, just open a new tab
if focused_ws_is "$WS" && focused_is_firefox; then
  nohup firefox --new-tab "$URL" >/dev/null 2>&1 &
  exit 0
fi


# If Firefox is already on the target workspace, focus it and open in a new tab.
# Otherwise, switch to the workspace and start Firefox there with the URL.
if check_in_ws "$WS" firefox; then
  # Focus the workspace and a Firefox window there first so the remote new-tab targets it.
  i3-msg -q "workspace number ${WS}" >/dev/null
  i3-msg -q '[class="(?i)firefox"] focus' >/dev/null
  # Open the URL in a new tab of the running instance
  sleep 0.1 # small sleep to ensure focus has taken effect
  nohup firefox --new-tab "$URL" >/dev/null 2>&1 &
else
  # Ensure we are on the correct workspace and launch Firefox with the URL there.
  i3-msg -q "workspace number ${WS}" >/dev/null
  # Quote the URL inside the i3 command to avoid shell interpretation of & and ?
  printf -v qurl '%q' "$URL"
  i3-msg -q "exec --no-startup-id firefox --new-window ${qurl}" >/dev/null
fi


