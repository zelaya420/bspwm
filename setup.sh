 #!/usr/bin/bash

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Global variables
dir=$(pwd)
fdir="$HOME/.local/share/fonts"
user=$(whoami)

trap ctrl_c INT

function ctrl_c(){
    echo -e "\n\n${redColour}[!] Exiting...\n${endColour}"
    exit 1
}

function banner(){
    echo -e "\n${turquoiseColour}              _____            ______"
    sleep 0.05
    echo -e "______ ____  ___  /______      ___  /___________________      ________ ___"
    sleep 0.05
    echo -e "_  __ \`/  / / /  __/  __ \     __  __ \_  ___/__  __ \_ | /| / /_  __ \`__ \\"
    sleep 0.05
    echo -e "/ /_/ // /_/ // /_ / /_/ /     _  /_/ /(__  )__  /_/ /_ |/ |/ /_  / / / / /"
    sleep 0.05
    echo -e "\__,_/ \__,_/ \__/ \____/      /_.___//____/ _  .___/____/|__/ /_/ /_/ /_/    ${endColour}${yellowColour}(${endColour}${grayColour}By ${endColour}${purpleColour}@zelaya420${endColour}${yellowColour})${endColour}${turquoiseColour}"
    sleep 0.05
    echo -e "                                             /_/${endColour}"
}

if [ "$user" == "root" ]; then
    banner
    echo -e "\n\n${redColour}[!] You should not run the script as the root user!\n${endColour}"
    exit 1
else
    banner
    sleep 1
    echo -e "\n\n${blueColour}[*] Installing necessary packages for the environment...\n${endColour}"
    sleep 2
    sudo apt install -y kitty rofi feh xclip ranger betterlockscreen playerctl scrot scrub wmname cargo rustc imagemagick cmatrix htop neofetch python3-pip procps tty-clock fzf lsd bat pamixer flameshot
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install some packages!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi

    echo -e "\n${blueColour}[*] Installing pywal...\n${endColour}"
    sleep 2
    sudo pip3 install pywal
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install pywal or operation cancelled by user!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi

    echo -e "\n${blueColour}[*] Starting installation of necessary dependencies for the environment...\n${endColour}"
    sleep 0.5

    echo -e "\n${purpleColour}[*] Installing necessary dependencies for bspwm...\n${endColour}"
    sleep 2
    sudo apt install -y build-essential git vim libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev libuv1-dev
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install some dependencies for bspwm!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi

    echo -e "\n${purpleColour}[*] Installing necessary dependencies for polybar...\n${endColour}"
    sleep 2
    sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install some dependencies for polybar!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi

    echo -e "\n${purpleColour}[*] Installing necessary dependencies for picom...\n${endColour}"
    sleep 2
    sudo apt install -y meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install some dependencies for picom!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi

    echo -e "\n${blueColour}[*] Starting installation of the tools...\n${endColour}"
    sleep 0.5
    mkdir ~/tools && cd ~/tools

    echo -e "\n${purpleColour}[*] Installing bspwm...\n${endColour}"
    sleep 2
    git clone https://github.com/baskerville/bspwm.git
    cd bspwm
    make -j$(nproc)
    sudo make install
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install bspwm!\n${endColour}"
        exit 1
    else
        sudo apt install bspwm -y
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi
    cd ..

    echo -e "\n${purpleColour}[*] Installing sxhkd...\n${endColour}"
    sleep 2
    git clone https://github.com/baskerville/sxhkd.git
    cd sxhkd
    make -j$(nproc)
    sudo make install
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install sxhkd!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi

    cd ..

    echo -e "\n${purpleColour}[*] Installing zscroll...\n${endColour}"
    sleep 2
    git clone https://github.com/noctuid/zscroll
    cd zscroll
    sudo python3 setup.py install
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install zscroll!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi
    cd ..

    echo -e "\n${purpleColour}[*] Installing polybar...\n${endColour}"
    sleep 2
    git clone --recursive https://github.com/polybar/polybar
    cd polybar
    mkdir build
    cd build
    cmake ..
    make -j$(nproc)
    sudo make install
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install polybar!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi
    cd ../..

    echo -e "\n${purpleColour}[*] Installing picom...\n${endColour}"
    sleep 2
    git clone https://github.com/yshui/picom
    cd picom
    meson build
    ninja -C build
    sudo ninja -C build install
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install picom!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi
    cd ..

    echo -e "\n${purpleColour}[*] Installing eww...\n${endColour}"
    sleep 2
    git clone https://github.com/elkowar/eww
    cd eww
    cargo build --release
    sudo cp target/release/eww /usr/local/bin/
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install eww!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi
    cd ..

    echo -e "\n${blueColour}[*] Configuring environment...\n${endColour}"
    sleep 0.5
    mkdir -p ~/.config/{bspwm,sxhkd,polybar,picom,eww} ~/.local/share/fonts

    echo -e "\n${blueColour}[*] Installing fonts...\n${endColour}"
    sleep 2
    mkdir -p ~/.local/share/fonts
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
    fc-cache -fv
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to install fonts!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi
    cd ..

    echo -e "\n${blueColour}[*] Copying configuration files...\n${endColour}"
    sleep 2
    cp -r ./config/bspwm ~/.config/
    cp -r ./config/sxhkd ~/.config/
    cp -r ./config/polybar ~/.config/
    cp -r ./config/picom ~/.config/
    cp -r ./config/eww ~/.config/
    cp ./fonts/* ~/.local/share/fonts/
    if [ $? != 0 ] && [ $? != 130 ]; then
        echo -e "\n${redColour}[-] Failed to copy configuration files!\n${endColour}"
        exit 1
    else
        echo -e "\n${greenColour}[+] Done\n${endColour}"
        sleep 1.5
    fi

    echo -e "\n${greenColour}[+] Setup complete!\n${endColour}"
fi
