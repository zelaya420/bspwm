import os, time
from sys import stdout

def red():
    RED = "\033[1;31m"
    stdout.write(RED)

def green():
    GREEN = "\033[0;32m"
    stdout.write(GREEN)

def blue():
    BLUE = "\033[1;34m"
    stdout.write(BLUE)

def yellow():
    YELLOW = "\033[1;33m"
    stdout.write(YELLOW)

def purple():
    PURPLE = "\033[1;35m"
    stdout.write(PURPLE)

def white():
    WHITE = "\033[1;37m"
    stdout.write(WHITE)

banner = """
 █████╗ ██╗   ██╗████████╗ ██████╗ ██████╗ ███████╗██████╗ ██╗    ██╗███╗   ███╗
██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗██║    ██║████╗ ████║  
███████║██║   ██║   ██║   ██║   ██║██████╔╝███████╗██████╔╝██║ █╗ ██║██╔████╔██║  
██╔══██║██║   ██║   ██║   ██║   ██║██╔══██╗╚════██║██╔═══╝ ██║███╗██║██║╚██╔╝██║  (by Pepe Zelaya)
██║  ██║╚██████╔╝   ██║   ╚██████╔╝██████╔╝███████║██║     ╚███╔███╔╝██║ ╚═╝ ██║
╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═════╝ ╚══════╝╚═╝      ╚══╝╚══╝ ╚═╝     ╚═╝
"""

def menu():
    red()
    print(banner)
    blue()
    time.sleep(1)
    print("1 -> Instalar Requerimientos necesarios")
    time.sleep(1)
    print("\n2 -> Instalar Bspwm")
    time.sleep(1)
    print("\n3 -> Instalar Polybar, Picom, Rofi...")
    time.sleep(1)
    print("\n4 -> All In One")
    time.sleep(1)
    print("\n5 -> Salir")
    time.sleep(1)

    option = input("\n-->> ")

    if option == "1":
        req()
    if option == "2":
        bspwm()
    if option == "3":
        polybar()
    if option == "4":
        req()
        bspwm()
        polybar()
    if option == "5":
        exit()

def req():
    green()
    print("[+] Instalando requerimientos...\n")

    # Instalando Requerimientos
    os.system("sudo apt-get update -y")
    os.system("sudo apt install net-tools libuv1-dev build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev -y")
    os.system("sudo apt install cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y")
    os.system("sudo apt install meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpcre3-dev -y")
    os.system("pip install Sphinx")
    os.system("sudo pip install Sphinx")
    os.system("sudo apt install bspwm rofi caja feh gnome-terminal scrot neovim xclip tmux acpi scrub polybar neofetch nitrogen thunar lxappearance kitty betterlockscreen playerctl zsh pavucontrol wmname maim viewnior  -y")
    os.system(" cd .config")
    os.system("git clone https://github.com/noctuid/zscroll")
    os.system("cd zscroll")
    os.system("sudo python3 setup.py install")
    time.sleep(2)
    print("[+] Requetimientos instalados correctamente")

def bspwm():
    green()

    # Clona la repo de bspwm
    os.system("git clone https://github.com/baskerville/bspwm.git")
    os.system("mv bspwm/* .")
    os.system("sudo rm -r bspwm/")
    os.system("make")

    # Acava del build
    os.system("sudo make install")

    # Elimina los archivos de bspwm
    os.system("sudo rm -r artworks/ contrib/ doc/ src/ tests/ bspc bspc.o bspwm bspwm.o desktop.o events.o ewmh.o geometry.o helpers.o history.o jsmn.o LICENSE Makefile messages.o monitor.o parse.o pointer.o query.o README.md restore.o rule.o settings.o Sourcedeps stack.o subscribe.o tree.o VERSION window.o")

    # Clona la repo de sxhkd
    os.system("git clone https://github.com/baskerville/sxhkd.git")
    os.system("mv sxhkd/* .")
    os.system("sudo rm -r sxhkd/")
    os.system("cd ../sxhkd")
    os.system("make")

    # Acaba el build
    os.system("sudo make install")

    # Crea las carpetas de bspwm y sxhkd en ~/.config
    os.system("mkdir ~/.config/bspwm")
    os.system("mkdir ~/.config/sxhkd")
    os.system("cp examples/bspwmrc ~/.config/bspwm/")

    # Les da permisos de ejecucion a bspwmrc
    os.system("chmod +x ~/.config/bspwm/bspwmrc")
    os.system("cp examples/sxhkdrc ~/.config/sxhkd/")

    # Elimina los archivos de sxhkd
    os.system("sudo rm -r contrib/ doc/ examples/ src/ grab.o helpers.o LICENSE Makefile parse.o README.md Sourcedeps sxhkd sxhkd.o types.o VERSION")
    os.system("cp tools/sxhkdrc ~/.config/sxhkd")
    print("\n[+] Bspwm instalado correctamente!")

def polybar():
    green()

    # Clona el repo de polybar
    os.system("git clone --recursive https://github.com/polybar/polybar")
    os.system("mv polybar/* .")
    os.system("sudo rm -r polybar/")
    os.system("cmake .")
    os.system("make -j$(nproc)")

    # Acaba el build
    os.system("sudo make install")

    # Elimina los archivos de polybar
    os.system("sudo rm -r bin/ cmake/ CMakeFiles/ common/ config/ contrib/ doc/ generated-sources/ include/ lib/ libs/ polybar/ src/ tests/ banner.png build.sh CHANGELOG.md CMajeCache.txt cmake_install.cmake CMakeLists.txt compile_commands.json CONTRIBUTING.md install_manifest LICENSE Makefile README.md SUPPORT.md version.txt")

    # Clona el repo de picom
    os.system("git clone https://github.com/ibhagwan/picom.git")
    os.system("mv picom/* .")
    os.system("sudo rm -r picom/")
    os.system("git submodule update --init --recursive")
    os.system("meson --buildtype=release . build")
    os.system("ninja -C build")

    # Hace el build de picom
    os.system("sudo ninja -C build install")

    # Elimina los archivos de picom
    os.system("sudo rm -r *.md *.conf *.desktop *.txt *.build *.spdx *.glsl COPYING Doxyfile CONTRIBUTORS bin/ build/ dbus-examples/ LICENSES/ man/ media/ meson/ src/ subprojects/ tests/")
    
    #zscroll install 
    os.system("cd $HOME/.config")    
    os.system("git clone https://github.com/noctuid/zscroll")
    os.system("cd zscroll")
    os.system("sudo python3 setup.py install")

    
     # spotify 
    # os.system("curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg")
    # os.system("echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list")
    # os.system("sudo apt-get update && sudo apt-get install spotify-client")
    #  os.system("sudo apt-get install spotify-client")

   
    expback = input("\nDesea usear los experimental-backends en picom? Si no se activa se puede detectar lentitud en el equipo al no disponer de una buena GPU. si/no -> ")

    if expback == "si":
        os.system("cp tools/picom.conf ~/.config/picom")

    if expback == "no":
        os.system("cp tools/picom-blur.conf ~/.config/picom/picom.conf")

    os.system("echo 'bspc config border_width 0' >> ~/.config/bspwm/bspwmrc")
 #   os.system("mkdir ~/.config/bin")
    os.system("echo 'picom --experimental-backends &' >> ~/.config/bspwm/bspwmrc")

    # Instalacion de Fuentes para Polybar
    os.system("sudo cp ~/.config/polybar/fonts/* /usr/share/fonts")

    # Instalando Oh My Tmux
    os.system("git clone https://github.com/gpakosz/.tmux.git /home/$USER/.tmux")
    os.system("ln -s -f .tmux/.tmux.conf /home/$USER")
    os.system("cp /home/$USER/.tmux/.tmux.conf.local /home/$USER")
    
    # Instalando Oh My Tmux para root
    os.system("sudo git clone https://github.com/gpakosz/.tmux.git /root/.tmux")
    os.system("sudo ln -s -f .tmux/.tmux.conf /root")
    os.system("sudo cp /root/.tmux/.tmux.conf.local /root")


    print("\n[+] POLYBAR INSTALADO!!!")

if __name__ == '__main__':
    id = os.getuid()
    
    if id == 0:
        red()
        print()
        print("[!] No hay que ser root para ejecutar la herramienta")
        print()
    else:
        menu()
