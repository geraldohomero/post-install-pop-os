#!/bin/bash

# Check if Syncthing is running using pgrep to verify the ID
if pgrep -x "syncthing" > /dev/null
then
    echo "Syncthing is running"
else
    echo "Syncthing is not running"
fi
