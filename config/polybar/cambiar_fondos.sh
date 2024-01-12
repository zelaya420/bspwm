#!/bin/bash

# Ruta a la carpeta que contiene las imágenes
carpeta_imagenes="~/Pictures/Wallapapers"

# Verificar si la carpeta existe
if [ ! -d "$carpeta_imagenes" ]; then
    echo "La carpeta de imágenes no existe: $carpeta_imagenes"
    exit 1
fi

# Bucle sobre cada archivo de imagen en la carpeta
for imagen in "$carpeta_imagenes"/*.jpg; do
    # Verificar si hay archivos de imagen
    if [ -e "$imagen" ]; then
        echo "Aplicando Pywal a la imagen: $imagen"
        pywal --quiet "$imagen"
    fi
done

echo "Cambio de fondos de pantalla completado."
