#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
BLUE='\e[1;94m'
ORANGE='\e[1;93m'
PURPLE='\e[1;95m'
NO_COLOR='\e[0m'

##############################################################################
# Add some development tools like node, npm, nvm, dotnet, EntityFramework... #
##############################################################################
echo -e "${PURPLE}[INFO] - Installing development tools...${NO_COLOR}"

# Node.js
if ! command -v node &> /dev/null; then
  echo -e "${RED}[ERROR] - Node.js is not installed.${NO_COLOR}"
  echo -e "${GREEN}[INFO] - Installing Node.js...${NO_COLOR}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    nvm install 20
  echo -e "${GREEN}[INFO] - Node.js has been successfully installed.${NO_COLOR}"
else
  echo -e "${ORANGE}[INFO] - Node.js is already installed.${NO_COLOR}"
fi

# .NET SDK 8.0
if ! command -v dotnet &> /dev/null; then
  echo -e "${RED}[ERROR] - .NET SDK 8.0 is not installed.${NO_COLOR}"
  echo -e "${GREEN}[INFO] - Installing .NET SDK 8.0...${NO_COLOR}"
    sudo apt update && \
    sudo apt-get install -y dotnet-sdk-8.0
  echo -e "${GREEN}[INFO] - .NET SDK 8.0 has been successfully installed.${NO_COLOR}"
else
  echo -e "${ORANGE}[INFO] - .NET SDK 8.0 is already installed.${NO_COLOR}"
fi

# Entity Framework Core
if ! command -v dotnet-ef &> /dev/null; then
  echo -e "${RED}[ERROR] - Entity Framework Core is not installed.${NO_COLOR}"
  echo -e "${GREEN}[INFO] - Installing Entity Framework Core...${NO_COLOR}"
    dotnet-ef
    dotnet tool install --global dotnet-ef
  echo -e "${GREEN}[INFO] - Entity Framework Core has been successfully installed.${NO_COLOR}"
else
  dotnet-ef
  echo -e "${ORANGE}[INFO] - Entity Framework Core is already installed.${NO_COLOR}"
fi