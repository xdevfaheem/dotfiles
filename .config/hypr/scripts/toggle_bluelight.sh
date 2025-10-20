#!/bin/bash

STATEFILE="/tmp/bluelight_state"

if [[ -f "$STATEFILE" ]]; then
    hyprctl hyprsunset identity
    rm "$STATEFILE"
else
    hyprctl hyprsunset temperature 3000
    touch "$STATEFILE"
fi

