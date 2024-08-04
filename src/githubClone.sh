#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

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

##########################################
# Change to the directory where you want # 
# to clone all the repositories          #
##########################################
DIRECTORY_PATH="$HOME/Documents/Github"  #
##########################################

echo -e "${GREEN}[INFO] - Cloning all repositories from $USER on GitHub to $DIRECTORY_PATH.${NO_COLOR}"
gh repo list $USER --limit 1000 | while read -r repo _; do gh repo clone "$repo" "$DIRECTORY_PATH/$repo"; done
