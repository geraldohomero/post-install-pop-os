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

## Add update.sh to home directory
echo -e "${VERDE}[INFO] - Adding update.sh to home directory.${SEM_COR}"
sleep 2
# Copy the update.sh script to the home directory
cp update.sh $HOME

echo -e "${VERDE}[INFO] - Making the update.sh script executable.${SEM_COR}"
sleep 2
# Make the update.sh script executable
chmod +x $HOME/update.sh

echo -e "${VERDE}[INFO] - Just type 'update' on the terminal to update/upgrade the system. See /home/.bash_aliases/ for more information.${SEM_COR}"
