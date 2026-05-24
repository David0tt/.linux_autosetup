#!/usr/bin/env bash
set -euo pipefail

config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
kglobalshortcuts_file="$config_home/kglobalshortcutsrc"
kwinrc_file="$config_home/kwinrc"

set_shortcut() {
    local group="$1"
    local key="$2"
    local value="$3"
    kwriteconfig6 --file "$kglobalshortcuts_file" --group "$group" --key "$key" "$value"
}

set_nested_shortcut() {
    local group1="$1"
    local group2="$2"
    local key="$3"
    local value="$4"
    kwriteconfig6 --file "$kglobalshortcuts_file" --group "$group1" --group "$group2" --key "$key" "$value"
}

set_kwin_mouse_binding() {
    local key="$1"
    local value="$2"
    kwriteconfig6 --file "$kwinrc_file" --group MouseBindings --key "$key" "$value"
}

for desktop in 1 2 3 4 5 6 7 8 9; do
    set_shortcut kwin "Switch to Desktop $desktop" "Meta+$desktop,,Switch to Desktop $desktop"
    set_shortcut kwin "Window to Desktop $desktop" "Meta+Shift+$desktop,,Window to Desktop $desktop"
    set_shortcut plasmashell "activate task manager entry $desktop" ",,Activate Task Manager Entry $desktop"
done
set_shortcut kwin "Switch to Desktop 10" "Meta+0,,Switch to Desktop 10"
set_shortcut kwin "Window to Desktop 10" "Meta+Shift+0,,Window to Desktop 10"
set_shortcut plasmashell "activate task manager entry 10" ",,Activate Task Manager Entry 10"

set_shortcut kwin "Switch Window Up" "Meta+Up,,Switch to Window Above"
set_shortcut kwin "Switch Window Down" "Meta+Down,,Switch to Window Below"
set_shortcut kwin "Switch Window Left" "Meta+Left,,Switch to Window to the Left"
set_shortcut kwin "Switch Window Right" "Meta+Right,,Switch to Window to the Right"

set_shortcut kwin "Window Pack Up" "Meta+Shift+Up,,Move Window Up"
set_shortcut kwin "Window Pack Down" "Meta+Shift+Down,,Move Window Down"
set_shortcut kwin "Window Pack Left" "Meta+Shift+Left,,Move Window Left"
set_shortcut kwin "Window Pack Right" "Meta+Shift+Right,,Move Window Right"

set_shortcut kwin "Window Quick Tile Top" ",,Quick Tile Window to the Top"
set_shortcut kwin "Window Quick Tile Bottom" ",,Quick Tile Window to the Bottom"
set_shortcut kwin "Window Quick Tile Left" ",,Quick Tile Window to the Left"
set_shortcut kwin "Window Quick Tile Right" ",,Quick Tile Window to the Right"
set_shortcut kwin "Window to Previous Screen" ",,Move Window to Previous Screen"
set_shortcut kwin "Window to Next Screen" ",,Move Window to Next Screen"

set_shortcut kwin "Window Fullscreen" "Meta+F,,Make Window Fullscreen"
set_shortcut kwin "Show Desktop" ",,Peek at Desktop"
set_nested_shortcut services org.kde.krunner.desktop _launch "Meta+D,,KRunner"

set_kwin_mouse_binding CommandAllKey Meta
set_kwin_mouse_binding CommandAll1 Move
set_kwin_mouse_binding CommandAll3 Resize

cat <<'EOF'
Applied i3-like KDE shortcut settings to:
  - ~/.config/kglobalshortcutsrc
  - ~/.config/kwinrc

Notes:
  - Meta+Shift+Arrow is mapped to KWin "Window Pack" actions. That moves the window on screen, but it is not the same as i3's container move semantics.
  - Stock KWin exposes Meta+drag move and Meta+right-drag resize. It does not expose a reliable Meta+middle-click close action through MouseBindings, so that part still needs either a custom KWin script or a different shortcut.
  - Log out and back in if KDE does not pick up the changes immediately.
EOF
