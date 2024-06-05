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

############################################################
## Add update.sh and syncthingStatus.sh to home directory ##
############################################################
echo -e "${VERDE}[INFO] - Adding update.sh and syncthingStatus.sh to home directory.${SEM_COR}"
sleep 2
# Copy the update.sh and syncthingStatus.sh script to the home directory
cp update.sh $HOME
cp syncthingStatus.sh $HOME

echo -e "${VERDE}[INFO] - Making the update.sh and syncthingStatus.sh script executable.${SEM_COR}"
sleep 2
# Make the update.sh and syncthingStatus.sh script executable
chmod +x $HOME/update.sh
chmod +x $HOME/syncthingStatus.sh

echo -e "${VERDE}[INFO] - Just type 'update' on the terminal to update/upgrade the system. See /home/.bash_aliases/ for more information.${SEM_COR}"
echo -e "${VERDE}[INFO] - Just type 'syncstatus' on the terminal to check Syncthing status.${SEM_COR}"

#################################################
## Clone all repositories from USER on GitHub  ##
## And verify if GitHub CLI is installed       ##
#################################################
echo -e "${VERDE}[INFO] - Checking if GitHub CLI is installed...${SEM_COR}"
if ! command -v gh &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - GitHub CLI is not installed.${SEM_COR}"
  echo -e "${VERDE}[INFO] - Installing GitHub CLI...${SEM_COR}"
  sudo apt install gh
  echo -e "${VERDE}[INFO] - GitHub CLI has been successfully installed.${SEM_COR}"
else
  echo -e "${VERDE}[INFO] - GitHub CLI is already installed.${SEM_COR}"
fi

sleep 2

USER="geraldohomero" # Change to your GitHub username
DIRECTORY_PATH="$HOME/Documents/Github" # Change to the directory where you want to clone the repositories

echo -e "${VERDE}[INFO] - Cloning all repositories from $USER on GitHub to $DIRECTORY_PATH.${SEM_COR}"
gh repo list $USER --limit 1000 | while read -r repo _; do gh repo clone "$repo" "$DIRECTORY_PATH/$repo"; done
