#!/usr/bin/env bash

# Define default brightness step
BRIGHTNESS_STEP=5

increase_brightness() {
    # Functionality from ob-brightness for increasing brightness
    light -A $BRIGHTNESS_STEP
}

decrease_brightness() {
    # Functionality from ob-brightness for decreasing brightness
    light -U $BRIGHTNESS_STEP
}

set_brightness() {
    # Functionality from t2-brightness for setting a specific brightness value
    VAL="$1"
    light -S $VAL
}

usage() {
    echo "Usage: $0 {increase|decrease|set <value>}"
    exit 1
}

# Check the passed argument and call the corresponding function
case "$1" in
    increase) increase_brightness ;;
    decrease) decrease_brightness ;;
    set) set_brightness "$2" ;;
    *) usage ;;
esac
