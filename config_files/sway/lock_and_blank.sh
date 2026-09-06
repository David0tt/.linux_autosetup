#!/bin/sh

swayidle -w \
  timeout 1 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' &
idle_pid=$!

cleanup() {
  kill "$idle_pid" >/dev/null 2>&1 || true
  swaymsg 'output * dpms on' >/dev/null 2>&1 || true
}

trap cleanup EXIT INT TERM

gtklock