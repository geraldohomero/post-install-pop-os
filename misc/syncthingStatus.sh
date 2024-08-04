#!/bin/bash
RED='\e[1;91m'
GREEN='\e[1;92m'

# Check if Syncthing is running
if pgrep -x "syncthing" > /dev/null
then
    echo -e "${GREEN}[INFO] - Syncthing is running. ${NO_COLOR}"
else
    echo -e "${RED}[INFO] - Syncthing is NOT running. ${NO_COLOR}"
fi
