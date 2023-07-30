#!/usr/bin/env bash
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'

# Change directory to the "Downloads" directory
cd "$HOME/Downloads/post-install-pop-os"

# Make the scripts executable
chmod +x post-install.sh alias.sh

echo -e "${VERDE}[INFO] - Post-installation script will be executed.${SEM_COR}"
sleep 2

# Run the post-install script
./post-install.sh

echo -e "${VERDE}[INFO] - .bash_aliases script will be executed.${SEM_COR}"
sleep 2

# Run the .bash_aliases script
./alias.sh

echo -e "${VERDE}[INFO] - Setup completed successfully.${SEM_COR}"
