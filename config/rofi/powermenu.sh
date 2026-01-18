# ______       __ _                                                                     _     
# | ___ \     / _(_)  _                                                                | |    
# | |_/ /___ | |_ _  (_)  _ __   _____      _____ _ __ _ __ ___   ___ _ __  _   _   ___| |__  
# |    // _ \|  _| |     | '_ \ / _ \ \ /\ / / _ \ '__| '_ ` _ \ / _ \ '_ \| | | | / __| '_ \ 
# | |\ \ (_) | | | |  _  | |_) | (_) \ V  V /  __/ |  | | | | | |  __/ | | | |_| |_\__ \ | | |
# \_| \_\___/|_| |_| (_) | .__/ \___/ \_/\_/ \___|_|  |_| |_| |_|\___|_| |_|\__,_(_)___/_| |_|
#  by Zelaya             | |   Zelaya420                                                               
#                        |_|                                                                  
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                                            
                                                                     

#!/usr/bin/env bash

options=(
    ""
    ""
    ""
    ""
    ""
)

rofi_cmd() {
	rofi -dmenu \
		-p "Goodbye ${USER}" \
		-mesg "Uptime: $(uptime -p | sed -e 's/up //g')" \
		-theme "$HOME"/.config/rofi/powermenu.rasi
}

chosen=$(printf "%s\n" "${options[@]}" | rofi_cmd)

case $chosen in
    "")
        systemctl poweroff
        ;;
    "")
        systemctl reboot
        ;;
    "")
	betterlockscreen -u ~/Wallpapers/435112.jpg -l
        ;;
    "")
        mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
    "")
        bspc quit
        ;;
esac
