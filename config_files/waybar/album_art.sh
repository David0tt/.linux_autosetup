#!/bin/sh

set -eu

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/waybar-media"
cover_path="$cache_dir/cover"
url_path="$cache_dir/art-url"

art_url=$(playerctl -s metadata mpris:artUrl 2>/dev/null || true)
title=$(playerctl -s metadata xesam:title 2>/dev/null || true)
artist=$(playerctl -s metadata xesam:artist 2>/dev/null || true)

if [ -z "$art_url" ]; then
    exit 1
fi

mkdir -p "$cache_dir"

current_url=""
if [ -f "$url_path" ]; then
    current_url=$(cat "$url_path")
fi

if [ "$art_url" != "$current_url" ] || [ ! -s "$cover_path" ]; then
    tmp_path="$cover_path.tmp"

    case "$art_url" in
        file://*)
            cp "${art_url#file://}" "$tmp_path"
            ;;
        *)
            curl -fsSL "$art_url" -o "$tmp_path"
            ;;
    esac

    mv "$tmp_path" "$cover_path"
    printf '%s' "$art_url" > "$url_path"
fi

printf '%s\n' "$cover_path"

tooltip=""
if [ -n "$title" ]; then
    tooltip=$title
fi

if [ -n "$artist" ]; then
    if [ -n "$tooltip" ]; then
        tooltip="$tooltip - $artist"
    else
        tooltip=$artist
    fi
fi

if [ -n "$tooltip" ]; then
    printf '%s\n' "$tooltip"
fi