#!/bin/bash
# Cycle active outputs through every possible left-to-right ordering.

set -euo pipefail

SWAYMSG=${SWAYMSG:-swaymsg}
OUTPUTS_JSON=$($SWAYMSG -t get_outputs)

readarray -t OUTPUTS < <(
    jq -r '
        [.[] | select(.active == true)]
        | sort_by(.rect.x, .rect.y, .name)
        | .[].name
    ' <<< "$OUTPUTS_JSON"
)

if (( ${#OUTPUTS[@]} < 2 )); then
    notify-send "Display layout" "Fewer than two displays are active." 2>/dev/null || true
    exit 0
fi

# Find the lexicographically next permutation of the current left-to-right
# order. After the last permutation, wrap around to the first one.
LC_ALL=C
pivot=-1
for (( i=${#OUTPUTS[@]}-2; i>=0; i-- )); do
    if [[ ${OUTPUTS[i]} < ${OUTPUTS[i+1]} ]]; then
        pivot=$i
        break
    fi
done

if (( pivot >= 0 )); then
    for (( i=${#OUTPUTS[@]}-1; i>pivot; i-- )); do
        if [[ ${OUTPUTS[pivot]} < ${OUTPUTS[i]} ]]; then
            tmp=${OUTPUTS[pivot]}
            OUTPUTS[pivot]=${OUTPUTS[i]}
            OUTPUTS[i]=$tmp
            break
        fi
    done
fi

for (( left=pivot+1, right=${#OUTPUTS[@]}-1; left<right; left++, right-- )); do
    tmp=${OUTPUTS[left]}
    OUTPUTS[left]=${OUTPUTS[right]}
    OUTPUTS[right]=$tmp
done

declare -A WIDTHS
while IFS=$'\t' read -r name width; do
    WIDTHS["$name"]=$width
done < <(jq -r '.[] | select(.active == true) | [.name, .rect.width] | @tsv' <<< "$OUTPUTS_JSON")

x=0
command=""
for name in "${OUTPUTS[@]}"; do
    # Connector names reported by wlroots normally look like DP-1 or eDP-1.
    [[ $name =~ ^[[:alnum:]_.-]+$ ]] || {
        printf 'Unsupported output name: %s\n' "$name" >&2
        exit 1
    }
    command+="output $name position $x 0; "
    (( x += WIDTHS[$name] ))
done

$SWAYMSG "$command" >/dev/null
notify-send "Display layout" "Left to right: ${OUTPUTS[*]}" 2>/dev/null || true
