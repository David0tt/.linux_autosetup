#!/bin/sh

set -u

battery=""
for candidate in /sys/class/power_supply/BAT*; do
    if [ -r "$candidate/capacity" ]; then
        battery=$candidate
        break
    fi
done

if [ -z "$battery" ]; then
    printf '{"text":"? %%","tooltip":"Battery information unavailable","class":"unknown"}\n'
    exit 0
fi

read_value() {
    if [ -r "$battery/$1" ]; then
        cat "$battery/$1"
    else
        printf '%s\n' "$2"
    fi
}

capacity=$(read_value capacity 0)
status=$(read_value status Unknown)
cycles=$(read_value cycle_count Unknown)

adapter_online=0
for adapter in /sys/class/power_supply/ADP* /sys/class/power_supply/AC*; do
    if [ -r "$adapter/online" ] && [ "$(cat "$adapter/online")" = 1 ]; then
        adapter_online=1
        break
    fi
done

if [ -r "$battery/energy_full" ] && [ -r "$battery/energy_full_design" ]; then
    full=$(cat "$battery/energy_full")
    design=$(cat "$battery/energy_full_design")
    full_display=$(awk -v value="$full" 'BEGIN { printf "%.2f Wh", value / 1000000 }')
    design_display=$(awk -v value="$design" 'BEGIN { printf "%.2f Wh", value / 1000000 }')
elif [ -r "$battery/charge_full" ] && [ -r "$battery/charge_full_design" ]; then
    full=$(cat "$battery/charge_full")
    design=$(cat "$battery/charge_full_design")
    full_display=$(awk -v value="$full" 'BEGIN { printf "%.2f Ah", value / 1000000 }')
    design_display=$(awk -v value="$design" 'BEGIN { printf "%.2f Ah", value / 1000000 }')
else
    full=0
    design=0
    full_display=Unknown
    design_display=Unknown
fi

if [ "$design" -gt 0 ] 2>/dev/null; then
    health=$(awk -v full="$full" -v design="$design" \
        'BEGIN { printf "%.1f", 100 * full / design }')
else
    health=Unknown
fi

case "$capacity" in
    ''|*[!0-9]*) capacity=0 ;;
esac

if [ "$capacity" -le 15 ]; then
    level_class=critical
elif [ "$capacity" -le 30 ]; then
    level_class=warning
else
    level_class=normal
fi

case "$status" in
    Charging)
        icon=󰃨
        status_class=charging
        status_label=Charging
        ;;
    Full)
        icon=
        status_class=full
        status_label=Full
        ;;
    "Not charging")
        if [ "$adapter_online" -eq 1 ]; then
            icon=
            status_class=plugged
            status_label=Plugged
        else
            icon=
            status_class=discharging
            status_label=Discharging
        fi
        ;;
    *)
        status_class=$(printf '%s' "$status" | tr '[:upper:] ' '[:lower:]-')
        status_label=$status
        if [ "$capacity" -le 20 ]; then
            icon=
        elif [ "$capacity" -le 40 ]; then
            icon=
        elif [ "$capacity" -le 60 ]; then
            icon=
        elif [ "$capacity" -le 80 ]; then
            icon=
        else
            icon=
        fi
        ;;
esac

printf '{"text":"%s%% %s","tooltip":"%s\\nBattery health: %s%%\\nPresent capacity / original capacity: %s / %s\\nCharge Cycles: %s","class":["%s","%s"],"percentage":%s}\n' \
    "$capacity" "$icon" "$status_label" "$health" \
    "$full_display" "$design_display" "$cycles" "$status_class" \
    "$level_class" "$capacity"
