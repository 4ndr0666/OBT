#!/usr/bin/env bash

# Files and Directories
PFILE="$HOME/.config/polybar/hack/colors.ini"
RFILE="$HOME/.config/polybar/hack/scripts/rofi/colors.rasi"

change_colors() {
    # Update Polybar colors
    sed -i -e "s/background = #.*/background = $BG/g" $PFILE
    sed -i -e "s/foreground = #.*/foreground = $FG/g" $PFILE
    sed -i -e "s/primary = #.*/primary = $AC/g" $PFILE
    
    # Update Rofi colors
    cat > $RFILE <<- EOF
	/* colors */

	* {
	  al:    #00000000;
	  bg:    ${BG}FF;
	  ac:    ${AC}FF;
	  se:    ${AC}26;
	  fg:    ${FG}FF;
	}
	EOF
	
    polybar-msg cmd restart
}

case $1 in
    dark)
        BG="#141C21"
        FG="#FFFFFF"
        AC="#1e88e5" # Default to blue for dark theme
        ;;
    light)
        BG="#FFFFFF"
        FG="#000000"
        AC="#1e88e5" # Default to blue for light theme
        ;;
    --amber)
        AC="#ffb300"
        ;;
    --blue)
        AC="#1e88e5"
        ;;
    --blue-gray)
        AC="#546e7a"
        ;;
    --brown)
        AC="#6d4c41"
        ;;
    --cyan)
        AC="#00acc1"
        ;;
    --deep-orange)
        AC="#f4511e"
        ;;
    --deep-purple)
        AC="#5e35b1"
        ;;
    --green)
        AC="#43a047"
        ;;
    --gray)
        AC="#757575"
        ;;
    --indigo)
        AC="#3949ab"
        ;;
    --light-blue)
        AC="#039be5"
        ;;
    --light-green)
        AC="#7cb342"
        ;;
    --lime)
        AC="#c0ca33"
        ;;
    --orange)
        AC="#fb8c00"
        ;;
    --pink)
        AC="#d81b60"
        ;;
    --purple)
        AC="#8e24aa"
        ;;
    --red)
        AC="#e53935"
        ;;
    --teal)
        AC="#00897b"
        ;;
    --yellow)
        AC="#fdd835"
        ;;
    *)
        echo "Invalid option: $1"
        exit 1
        ;;
esac

change_colors
