#!/usr/bin/env bash

## Files and Directories
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SFILE="$DIR/system.ini"
RFILE="$DIR/.system"
STYLE="4ndr0hack"

## Get system variable values for various modules
get_values() {
    CARD=$(light -L | grep 'backlight' | head -n1 | cut -d'/' -f3)
    BATTERY=$(upower -i $(upower -e | grep 'BAT') | grep 'native-path' | cut -d':' -f2 | tr -d '[:blank:]')
    ADAPTER=$(upower -i $(upower -e | grep 'AC') | grep 'native-path' | cut -d':' -f2 | tr -d '[:blank:]')
    INTERFACE=$(ip link | awk '/state UP/ {print $2}' | tr -d :)
}

## Write values to `system.ini` file
set_values() {
    if [[ "$ADAPTER" ]]; then
        sed -i -e "s/sys_adapter = .*/sys_adapter = $ADAPTER/g" ${SFILE}
    fi
    if [[ "$BATTERY" ]]; then
        sed -i -e "s/sys_battery = .*/sys_battery = $BATTERY/g" ${SFILE}
    fi
    if [[ "$CARD" ]]; then
        sed -i -e "s/sys_graphics_card = .*/sys_graphics_card = $CARD/g" ${SFILE}
    fi
    if [[ "$INTERFACE" ]]; then
        sed -i -e "s/sys_network_interface = .*/sys_network_interface = $INTERFACE/g" ${SFILE}
    fi
}

## Launch Polybar with selected style
launch_bar() {
    bash "$HOME/.config/openbox-themes/themes/$STYLE/polybar/launch.sh"
}

# Check for force flag
FORCE_UPDATE=0
if [[ "$1" == "-f" || "$1" == "--force" ]]; then
    FORCE_UPDATE=1
fi

# Execute functions
if [[ ! -f "$RFILE" ]] || [[ "$FORCE_UPDATE" -eq 1 ]]; then
    get_values
    set_values
    if [[ "$FORCE_UPDATE" -eq 0 ]]; then
        touch ${RFILE}
    fi
fi

launch_bar
