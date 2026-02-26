#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

echo -e "${GREEN}Installing Windscribe VPN...${NO_COLOR}"
    cd /tmp || { echo -e "${RED}Failed to change directory to /tmp.${NO_COLOR}"; exit 1; }
    if ! wget -O windscribe.deb "https://windscribe.com/install/desktop/linux_deb_x64"; then
        echo -e "${RED}Failed to download Windscribe DEB package.${NO_COLOR}"
        exit 1
    fi
    if command -v apt-get &>/dev/null; then
        if ! sudo apt install -y ./windscribe.deb; then
            echo -e "${ORANGE}apt install failed, trying dpkg...${NO_COLOR}"
            if ! sudo dpkg -i windscribe.deb; then
                echo -e "${RED}Failed to install Windscribe VPN with apt/dpkg.${NO_COLOR}"
                rm -f windscribe.deb
                exit 1
            fi
        fi
    elif command -v dpkg &>/dev/null; then
        if ! sudo dpkg -i windscribe.deb; then
            echo -e "${RED}Failed to install Windscribe VPN with dpkg.${NO_COLOR}"
            rm -f windscribe.deb
            exit 1
        fi
    else
        echo -e "${RED}No supported package manager found (apt/dpkg).${NO_COLOR}"
        rm -f windscribe.deb
        exit 1
    fi
    rm -f windscribe.deb
    echo -e "${GREEN}Windscribe VPN installation completed.${NO_COLOR}"
    