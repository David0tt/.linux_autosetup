#!/bin/sh

status=$(playerctl --player=playerctld -s status 2>/dev/null || true)

case "$status" in
    Playing)
        printf ''
        ;;
    Paused|Stopped)
        printf ''
        ;;
    *)
        printf ''
        ;;
esac