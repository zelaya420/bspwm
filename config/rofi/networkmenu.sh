#!/bin/bash

# Obtén las redes Wi-Fi disponibles usando nmcli
networks=$(nmcli -t -f SSID dev wifi list | sort | uniq)

# Verifica si hay redes disponibles
if [ -z "$networks" ]; then
    echo "No Wi-Fi networks found."
    exit 1
fi

# Usa rofi para mostrar las redes y seleccionar una
selected_network=$(echo "$networks" | rofi -dmenu -i -p "Select Wi-Fi Network:" -theme ~/.config/rofi/networkmenu.rasi)

# Si se seleccionó una red
if [[ ! -z "$selected_network" ]]; then
    # Verifica si la red ya está guardada
    saved_connection=$(nmcli -g NAME connection show | grep -Fx "$selected_network")

    if [[ ! -z "$saved_connection" ]]; then
        echo "Conectando automáticamente a $selected_network..."
        nmcli connection up "$selected_network"
        
        # Si la conexión falla, pedir nueva contraseña
        if [[ $? -ne 0 ]]; then
            echo "Error al conectar. Se requiere una nueva contraseña."
            nmcli connection delete "$selected_network"
            saved_connection=""
        else
            exit 0
        fi
    fi

    # Si la red no estaba guardada o se eliminó por error, pedir contraseña
    password=$(zenity --entry --title="Wi-Fi Connection" --text="Enter password for $selected_network:" --hide-text=false)

    # Verifica que se haya introducido una contraseña
    if [[ ! -z "$password" ]]; then
        echo "La contraseña ingresada es: $password"
        read -p "Presiona Enter para continuar..."

        # Borra configuraciones previas de la misma red
        nmcli connection delete "$selected_network" 2>/dev/null

        # Agrega una nueva conexión con la configuración correcta
        nmcli connection add type wifi ifname wlan0 con-name "$selected_network" ssid "$selected_network"

        # Configura la seguridad WPA-PSK y la contraseña
        nmcli connection modify "$selected_network" wifi-sec.key-mgmt wpa-psk
        nmcli connection modify "$selected_network" wifi-sec.psk "$password"

        # Activa la conexión
        nmcli connection up "$selected_network"
    else
        echo "No password entered. Aborting connection."
        exit 1
    fi
fi
