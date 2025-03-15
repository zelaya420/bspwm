#!/usr/bin/env bash

# Color files
PFILE="$HOME/.config/polybar/colors.ini"
RFILE="$HOME/.config/rofi/colors.rasi"
SFILE="$HOME/.config/eww/colors.scss"
WFILE="$HOME/.cache/wal/colors.sh"

# Get colors
pywal_get() {
	wal -i "$1" -q -t
}

# Change colors
change_color() {
	# polybar
	sed -i -e "s/background = #.*/background = $BG/g" $PFILE
	sed -i -e "s/foreground = #.*/foreground = $FG/g" $PFILE
	sed -i -e "s/foreground-alt = #.*/foreground-alt = $FGA/g" $PFILE
	sed -i -e "s/shade1 = #.*/shade1 = $SH1/g" $PFILE
	sed -i -e "s/shade2 = #.*/shade2 = $SH2/g" $PFILE
	sed -i -e "s/shade3 = #.*/shade3 = $SH3/g" $PFILE
	sed -i -e "s/shade4 = #.*/shade4 = $SH4/g" $PFILE
	sed -i -e "s/shade5 = #.*/shade5 = $SH5/g" $PFILE
	sed -i -e "s/shade6 = #.*/shade6 = $SH6/g" $PFILE
	sed -i -e "s/shade7 = #.*/shade7 = $SH7/g" $PFILE
	sed -i -e "s/shade8 = #.*/shade8 = $SH8/g" $PFILE
	
	# rofi
	cat > $RFILE <<- EOF
        /* colors */

	* {
	  al:    #00000000;
	  bg:    ${BG}FF;
	  bg1:   ${SH2}FF;
	  bg2:   ${SH3}FF;
	  bg3:   ${SH4}FF;
	  fg:    ${FG}FF;
          ac:    ${SH5}FF;  /* Color de acento */
          bar:   ${SH6}FF;  /* Color de barra */
          bga:   ${SH7}FF;  /* Color de fondo del elemento seleccionado */
	}
	EOF
	
	# eww (colors.scss)
	cat > $SFILE <<- EOF
	\$bg: ${BG};
	\$bg-alt: ${SH1};
	\$fg: ${FG};
	\$black: ${SH1};
	\$lightblack: ${SH8};
	\$red: #f7768e;
	\$blue: #7aa2f7;
	\$cyan: #7dcfff;
	\$magenta: #bb9af7;
	\$green: #9ece6a;
	\$yellow: #e0af68;
	\$archicon: #0f94d2;
	EOF

	polybar-msg cmd restart
}



# Main
if [[ -x "`which wal`" ]]; then
	if [[ "$1" ]]; then
		pywal_get "$1"

		# Source the pywal color file
		if [[ -e "$WFILE" ]]; then
			. "$WFILE"
		else
			echo 'Color file does not exist, exiting...'
			exit 1
		fi

		# Ensure colors are not empty
		BG=${background:-"#000000"}
		FG=${foreground:-"#FFFFFF"}
		FGA=${color8:-$FG}
		SH1=${color1:-$BG}
		SH2=${color2:-$BG}
		SH3=${color3:-$BG}
		SH4=${color4:-$BG}
		SH5=${color5:-$BG}
		SH6=${color6:-$BG}
		SH7=${color7:-$BG}
		SH8=${color8:-$BG}
		
		change_color
	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./pywal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
