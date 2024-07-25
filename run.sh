#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'


# Change directory to the "Downloads" directory
cd "$HOME/Downloads/post-install-pop-os"

# Make the scripts executable
chmod +x post-install.sh alias.sh

echo -e "${GREEN}[INFO] - Post-installation script will be executed.${NO_COLOR}"
sleep 2

# Run the post-install script
./post-install.sh

echo -e "${GREEN}[INFO] - .bash_aliases script will be executed.${NO_COLOR}"
sleep 2

# Run the .bash_aliases script
./alias.sh

echo -e "${GREEN}[INFO] - Setup completed successfully.${NO_COLOR}"
sleep 2

echo -e "${PURPLE}[INFO] - Now some additional steps will be executed.${NO_COLOR}"
########################################################################
## Add update.sh, syncthingStatus.sh and swapAudio. to home directory ##
########################################################################
echo -e "${GREEN}[INFO] - Adding update.sh and syncthingStatus.sh to home directory.${NO_COLOR}"
sleep 2

# Copy the update.sh, syncthingStatus.sh and swapAudio.sh script to the home directory
cp misc/update.sh $HOME
cp misc/syncthingStatus.sh $HOME
cp misc/swapAudio.sh $HOME/swapAudio22.sh

echo -e "${GREEN}[INFO] - Making the update.sh, syncthingStatus.sh and swapAudio.sh script executable.${NO_COLOR}"
sleep 2
chmod +x $HOME/update.sh
chmod +x $HOME/syncthingStatus.sh
chmod +x $HOME/swapAudio.sh

echo -e "${GREEN}[INFO] - Just type 'update' on the terminal to update/upgrade the system. See /home/.bash_aliases/ for more information.${NO_COLOR}"
echo -e "${GREEN}[INFO] - Just type 'syncstatus' on the terminal to check Syncthing status.${NO_COLOR}"
echo -e "${GREEN}[INFO] - Just type 'swap' on the terminal to swap audio output. It doesn't keep the changes after reboot. Only use when needed.${NO_COLOR}"

#################################################
## Clone all repositories from USER on GitHub  ##
## And verify if GitHub CLI is installed       ##
#################################################
echo -e "${GREEN}[INFO] - Checking if GitHub CLI is installed...${NO_COLOR}"
if ! command -v gh &> /dev/null; then
  echo -e "${RED}[ERROR] - GitHub CLI is not installed.${NO_COLOR}"
  echo -e "${GREEN}[INFO] - Installing GitHub CLI...${NO_COLOR}"

  sudo apt install gh

  echo -e "${GREEN}[INFO] - GitHub CLI has been successfully installed.${NO_COLOR}"
else
  echo -e "${ORANGE}[INFO] - GitHub CLI is already installed.${NO_COLOR}"
fi

sleep 2

# Clone all repositories from USER on GitHub
echo -e "${GREEN}[INFO] - Enter the GitHub ${RED}username ${GREEN}to clone the repositories:${NO_COLOR}"
echo -n "GitHub username: "
read USER

DIRECTORY_PATH="$HOME/Documents/Github" # Change to the directory where you want to clone the repositories

echo -e "${GREEN}[INFO] - Cloning all repositories from $USER on GitHub to $DIRECTORY_PATH.${NO_COLOR}"
gh repo list $USER --limit 1000 | while read -r repo _; do gh repo clone "$repo" "$DIRECTORY_PATH/$repo"; done
