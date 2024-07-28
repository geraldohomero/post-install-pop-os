#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

########################################################################
## Add update.sh, syncthingStatus.sh and swapAudio. to home directory ##
########################################################################
echo -e "${GREEN}[INFO] - Adding update.sh and syncthingStatus.sh to home directory.${NO_COLOR}"
sleep 2

# Copy the update.sh, syncthingStatus.sh and swapAudio.sh script to the home directory
cp misc/update.sh $HOME
cp misc/syncthingStatus.sh $HOME
cp misc/swapAudio.sh $HOME

echo -e "${GREEN}[INFO] - Making the update.sh, syncthingStatus.sh and swapAudio.sh script executable.${NO_COLOR}"
sleep 2
chmod +x $HOME/update.sh
chmod +x $HOME/syncthingStatus.sh
chmod +x $HOME/swapAudio.sh

echo -e "${GREEN}[INFO] - Just type 'update' on the terminal to update/upgrade the system. See /home/.bash_aliases/ for more information.${NO_COLOR}"
echo -e "${GREEN}[INFO] - Just type 'syncstatus' on the terminal to check Syncthing status.${NO_COLOR}"
echo -e "${GREEN}[INFO] - Just type 'swap' on the terminal to swap audio output. It doesn't keep the changes after reboot. Only use when needed.${NO_COLOR}"
