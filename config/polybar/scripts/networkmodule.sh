#;; ┌────────────────────────────────────────────────────────────────┐
#;; │░█▀█░█▀█░█░░░█░█░█▀▄░█▀█░█▀▄░░░░░░░░░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀│
#;; │░█▀▀░█░█░█░░░░█░░█▀▄░█▀█░█▀▄░░░░▀░░░░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█│
#;; │░▀░░░▀▀▀░▀▀▀░░▀░░▀▀░░▀░▀░▀░▀░░░░▀░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀│
#;; │░networkmodule.sh░By░zelaya░zelaya420░░░░░░░░░░░░░░░░░░░░░░░░░░░│
#;; └────────────────────────────────────────────────────────────────┘

#!/bin/bash

# Obtiene el SSID de la red actual y la señal
current_network=$(nmcli -t -f NAME connection show --active | head -n 1)
signal_strength=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^\*' | cut -d':' -f2)

# Íconos de Hack Nerd Fonts
icon_no_signal="󰤭"  # Sin conexión
icon_weak="󰤟"        # Señal débil
icon_medium="󰤢"      # Señal media
icon_strong="󰤨"      # Señal fuerte

# Determina qué icono mostrar según la intensidad de la señal
if [ -z "$current_network" ]; then
    echo "$icon_no_signal"
else
    if [ "$signal_strength" -ge 75 ]; then
        echo "$icon_strong"
    elif [ "$signal_strength" -ge 50 ]; then
        echo "$icon_medium"
    else
        echo "$icon_weak"
    fi
fi

# Si se hace clic en el módulo, abrir Rofi para cambiar de red
if [ "$1" == "--switch" ]; then
    networks=$(nmcli -t -f SSID dev wifi | sort -u | grep -v "^\s*$")

    if [ -z "$networks" ]; then
        notify-send "Wi-Fi" "No hay redes disponibles" -i network-wireless-off
        exit 1
    fi

    selected_network=$(echo "$networks" | rofi -dmenu -i -p "Selecciona una red Wi-Fi:" -theme ~/.config/rofi/networkmenu.rasi)

    if [ ! -z "$selected_network" ]; then
        if nmcli connection show "$selected_network" &>/dev/null; then
            nmcli connection up "$selected_network"
        else
            password=$(rofi -dmenu -p "Contraseña para $selected_network:" -theme ~/.config/rofi/networkmenu.rasi)

            if [ ! -z "$password" ]; then
                nmcli dev wifi connect "$selected_network" password "$password"
            fi
        fi
    fi
fi
