#!/bin/sh

set -eu

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/waybar-media"
cover_path="$cache_dir/cover-square.png"
url_path="$cache_dir/art-url"

art_url=$(playerctl --player=playerctld -s metadata mpris:artUrl 2>/dev/null || true)
title=$(playerctl --player=playerctld -s metadata xesam:title 2>/dev/null || true)
artist=$(playerctl --player=playerctld -s metadata xesam:artist 2>/dev/null || true)

if [ -z "$art_url" ]; then
    exit 1
fi

mkdir -p "$cache_dir"

current_url=""
if [ -f "$url_path" ]; then
    current_url=$(cat "$url_path")
fi

if [ "$art_url" != "$current_url" ] || [ ! -s "$cover_path" ]; then
    source_tmp="$cache_dir/cover-source.$$"
    cover_tmp="$cache_dir/cover-square.$$.png"

    trap 'rm -f "$source_tmp" "$cover_tmp"' EXIT HUP INT TERM

    case "$art_url" in
        file://*)
            cp "${art_url#file://}" "$source_tmp"
            ;;
        *)
            curl -fsSL "$art_url" -o "$source_tmp"
            ;;
    esac

    # Waybar preserves the image's aspect ratio. Crop it to a centered square
    # first so wide cover art fills the entire media-art module.
    magick "$source_tmp[0]" \
        -auto-orient \
        -resize '256x256^' \
        -gravity center \
        -extent 256x256 \
        "$cover_tmp"

    mv "$cover_tmp" "$cover_path"
    printf '%s' "$art_url" > "$url_path"
    rm -f "$source_tmp"
    trap - EXIT HUP INT TERM
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
