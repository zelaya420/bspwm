;; ┌────────────────────────────────────────────────────────────────┐
;; │░█▀█░█▀█░█░░░█░█░█▀▄░█▀█░█▀▄░░░░░░░░░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀│
;; │░█▀▀░█░█░█░░░░█░░█▀▄░█▀█░█▀▄░░░░▀░░░░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█│
;; │░▀░░░▀▀▀░▀▀▀░░▀░░▀▀░░▀░▀░▀░▀░░░░▀░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀│
;; │░cambiar_fondos.py░By░zelaya░zelaya420░░░░░░░░░░░░░░░░░░░░░░░░│
;; └────────────────────────────────────────────────────────────────┘


import os
import time
import random

# Ruta del script pywal.sh
ruta_script_pywal = "~/.config/polybar/pywal.sh"

# Ruta de la carpeta con las imágenes
carpeta_imagenes = "~/Wallpapers"

# Obtener la ruta completa del script y del directorio de imágenes
ruta_completa_script = os.path.expanduser(ruta_script_pywal)
ruta_completa_imagenes = os.path.expanduser(carpeta_imagenes)

# Listar archivos en la carpeta
archivos = os.listdir(ruta_completa_imagenes)

while True:
    # Elegir una imagen aleatoria
    imagen_aleatoria = random.choice([archivo for archivo in archivos if archivo.endswith((".jpg", ".png"))])

    # Construir la ruta completa de la imagen
    ruta_imagen = os.path.join(ruta_completa_imagenes, imagen_aleatoria)

    # Comando para ejecutar pywal con la ruta especificada
    comando_pywal = f"{ruta_completa_script} {ruta_imagen}"

    # Ejecutar el comando
    os.system(comando_pywal)

    # Pausar durante 4 minutos
    time.sleep(24)
