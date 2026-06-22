#!/usr/bin/env bash
# Adjust brightness on all displays via ddcutil-service.
# State is updated immediately; I2C writes run in background so keypresses feel instant.
set -euo pipefail

DEST="com.ddcutil.DdcutilService"
OBJ="/com/ddcutil/DdcutilObject"
IFACE="com.ddcutil.DdcutilInterface"
VCP=16  # 0x10 = brightness

DIRECTION=${1:?usage: brightness.sh up|down [step]}
STEP=${2:-10}
STATE="${XDG_STATE_HOME:-$HOME/.local/state}/hypr-brightness"

# Seed state file from live values (runs only on first use or after `rm -rf $STATE`)
init_state() {
    mkdir -p "$STATE"
    for d in 1 2 3; do
        result=$(gdbus call --session --dest "$DEST" --object-path "$OBJ" \
            --method "$IFACE.GetVcp" "$d" "" "$VCP" 0)
        echo "$result" | grep -oP 'uint16 \K[0-9]+' | paste - - \
            | awk '{print $1 ":" $2}' > "$STATE/$d"
    done
}

[[ -f "$STATE/1" && -f "$STATE/2" && -f "$STATE/3" ]] || init_state

setvcp() {
    local d=$1
    local cur max new
    IFS=: read -r cur max < "$STATE/$d"

    if [[ "$DIRECTION" == "up" ]]; then
        new=$(( cur + STEP > max ? max : cur + STEP ))
    else
        new=$(( cur - STEP < 0 ? 0 : cur - STEP ))
    fi

    # Update state immediately so the next keypress sees the right value
    echo "$new:$max" > "$STATE/$d"

    # Fire I2C write in background — monitor takes ~600ms to apply it
    gdbus call --session --dest "$DEST" --object-path "$OBJ" \
        --method "$IFACE.SetVcp" "$d" "" "$VCP" "$new" 0 > /dev/null &
}

setvcp 1; setvcp 2; setvcp 3
disown -a
