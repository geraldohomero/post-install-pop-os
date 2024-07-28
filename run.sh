#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

# Change directory to the "Downloads" directory
cd "$HOME/Downloads/post-install-pop-os"

# Make the scripts on /src/ executable
chmod +x ./src/post-install.sh ./src/alias.sh ./src/homeScript.sh ./src/devEnv.sh ./src/githubClone.sh

echo -e "${GREEN}[INFO] - Post-installation script will be executed.${NO_COLOR}"
sleep 2

# Run the post-install script
./src/post-install.sh

echo -e "${GREEN}[INFO] - .bash_aliases script will be executed.${NO_COLOR}"
sleep 2

# Run the .bash_aliases script
./src/alias.sh

echo -e "${PURPLE}[INFO] - Now some additional steps will be executed.${NO_COLOR}"
sleep 2

# Add update.sh, syncthingStatus.sh and swapAudio. to home directory
./src/homeScript.sh

# Clone all repositories from USER on GitHub  #
./src/githubClone.sh

# Add some development tools like node, npm, nvm, dotnet, EntityFramework... 
./src/devEnv.sh
