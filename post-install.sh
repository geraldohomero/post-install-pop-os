#!/usr/bin/env bash
RED='\e[1;91m'
GREEN='\e[1;92m'
NO_COLOR='\e[0m'
#-----------https://github.com/geraldohomero/-------------#
#----------https://geraldohomero.github.io/---------------#
#------------A personal script project-------------------#

DOWNLOAD_PROGRAMS_DIRECTORY="$HOME/Downloads/Programas"
PROGRAMS_TO_INSTALL_DEB=(
  https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megasync-xUbuntu_22.04_amd64.deb
  https://mega.nz/linux/repo/xUbuntu_22.04/amd64/nautilus-megasync-xUbuntu_22.04_amd64.deb
  https://github.com/fastfetch-cli/fastfetch/releases/download/2.11.2/fastfetch-linux-amd64.deb
)
PROGRAMS_TO_INSTALL_APT=(
  btop
  openjdk-8-jre
  libreoffice-java-common
  virtualbox
  gnome-tweaks
  hugo
  vim
  neovim
  gufw 
  git
  gh
  steam
  code
)
PROGRAMS_TO_INSTALL_FLATPAK=(
  org.qbittorrent.qBittorrent
  org.kde.okular
  org.zotero.Zotero
  org.standardnotes.standardnotes  
  org.gnome.Characters
  com.bitwarden.desktop
  com.brave.Browser
  com.heroicgameslauncher.hgl
  com.microsoft.Edge
  com.spotify.Client
  com.axosoft.GitKraken
  com.github.tchx84.Flatseal
  com.github.tenderowl.frog
  com.google.AndroidStudio
  com.usebottles.bottles
  com.spotify.Client
  md.obsidian.Obsidian 
  io.gitlab.librewolf-community
  io.missioncenter.MissionCenter
  rest.insomnia.Insomnia
)

#--------------Validations-------------#
# Internet?
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${RED}[ERROR] - Your computer does not have an Internet connection.${NO_COLOR}"
  exit 1
else
  echo -e "${GREEN}[INFO] - Internet connection verified.${NO_COLOR}"
fi


# Is wget installed? #
if [[ ! -x $(which wget) ]]; then
  echo -e "${RED}[ERROR] - The wget program is not installed.${NO_COLOR}"
  echo -e "${GREEN}[INFO] - Installing wget...${NO_COLOR}"
  sudo apt install wget -y &> /dev/null
else
  echo -e "${GREEN}[INFO] - The wget program is already installed.${NO_COLOR}"
fi

# Updates and upgrades #
upgrade_cleanup () {
  echo -e "${GREEN}[INFO] - Performing upgrade and cleanup...${NO_COLOR}"
  sleep 1
  sudo apt autoclean
  sudo apt clean
  sudo apt update -m
  sudo dpkg --configure -a
  sudo apt install -f
  sudo apt full-upgrade
  sudo apt autoremove -y
  flatpak update
  #flatpak repair --user
  #flatpak remove --unused
}

# Installing packages and programs #
install_apt_packages() {
  for program in ${PROGRAMS_TO_INSTALL_APT[@]}; do
    if ! dpkg -l | grep -q $program; then
      echo -e "${GREEN}[INFO] - Installing $program...${NO_COLOR}"
      sudo apt install $program -y &> /dev/null
    else
      echo -e "${GREEN}[INFO] - The package $program is already installed.${NO_COLOR}"
    fi
  done
}

update_repositories() {
  echo -e "${GREEN}[INFO] - Updating repositories...${NO_COLOR}"
  sudo apt update &> /dev/null
}

install_flatpak () {
  # Add Flathub repository
  if ! flatpak remote-list | grep -q "flathub"; then
    echo -e "${GREEN}[INFO] - Adding Flathub repository...${NO_COLOR}"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  else
    echo -e "${GREEN}[INFO] - Flathub repository is already added.${NO_COLOR}"
  fi
  # Install flatpak
  for program in ${PROGRAMS_TO_INSTALL_FLATPAK[@]}; do
    if ! flatpak list | grep -q $program; then
          echo -e "${GREEN}[INFO] - Installing $program...${NO_COLOR}"
      flatpak install flathub $program -y
    else
      echo -e "${GREEN}[INFO] - $program flatpak is already installed.${NO_COLOR}"
    fi
  done
}


download_deb_packages () {
  # Add the directory for downloads if it does not exist
  [[ ! -d "$DOWNLOAD_PROGRAMS_DIRECTORY" ]] && mkdir "$DOWNLOAD_PROGRAMS_DIRECTORY"

  for url in "${PROGRAMS_TO_INSTALL_DEB[@]}"; do
    package_name=$(basename "$url")
    destination_path="$DOWNLOAD_PROGRAMS_DIRECTORY/$package_name"

    echo -e "${GREEN}[INFO] - Downloading package from URL: $url${NO_COLOR}"
    wget -c "$url" -P "$DOWNLOAD_PROGRAMS_DIRECTORY" &> /dev/null

    echo -e "${GREEN}[INFO] - Installing package: $package_name${NO_COLOR}"
    sudo dpkg -i "$destination_path"
    sudo apt -f install -y &> /dev/null
  done
}

install_protonvpn() {
##############################################################
## Download instructions from:                              ##
## https://protonvpn.com/support/official-ubuntu-vpn-setup/ ##
##############################################################
  echo -e "${GREEN}[INFO] - Downloading and cheking the Proton VPN...${NO_COLOR}"
  wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
  sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb && sudo apt update
  echo "de7ef83a663049b5244736d3eabaacec003eb294a4d6024a8fbe0394f22cc4e5  protonvpn-stable-release_1.0.3-3_all.deb" | sha256sum --check -
  sudo apt update && sudo apt upgrade
  sudo apt install proton-vpn-gnome-desktop
  sudo apt update && sudo apt upgrade
  echo -e "${GREEN}[INFO] - Downloading dependecies for tray icons on Ubuntu and Pop!_OS...${NO_COLOR}"
  sudo apt install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator -y
}

# install_surfshark () {
#  echo -e "${GREEN}[INFO] - Downloading the Surfshark VPN installation script...${NO_COLOR}"
#  curl -f https://downloads.surfshark.com/linux/debian-install.sh --output surfshark-install.sh
#  echo -e "${GREEN}[INFO] - Downloaded installation script. Displaying the script contents:${NO_COLOR}"
#  cat surfshark-install.sh
#  echo -e "${GREEN}[INFO] - Running the Surfshark VPN installation script...${NO_COLOR}"
#  sh surfshark-install.sh
#  Check if the installation was successful
#  if dpkg -l | grep -q "surfshark"; then
#  echo -e "${GREEN}[INFO] - Surfshark VPN has been successfully installed.${NO_COLOR}"
#  else
#    echo -e "${RED}[ERROR] - An error occurred during the installation of Surfshark VPN.${NO_COLOR}"
#  fi
#}

install_syncthing () {
  # Add the release PGP keys
  echo -e "${GREEN}[INFO] - Adding the release PGP keys...${NO_COLOR}"
  sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
  # Add the stable channel to APT sources
  echo -e "${GREEN}[INFO] - Adding the \"stable\" channel to APT sources...${NO_COLOR}"
  echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
  # Add the candidate channel to APT sources
  echo -e "${GREEN}[INFO] - Adding the \"candidate\" channel to APT sources...${NO_COLOR}"
  echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing candidate" | sudo tee -a /etc/apt/sources.list.d/syncthing.list
  # Update APT
  echo -e "${GREEN}[INFO] - Updating APT...${NO_COLOR}"
  sudo apt update &> /dev/null
  # Install Syncthing
  echo -e "${GREEN}[INFO] - Installing Syncthing...${NO_COLOR}"
  sudo apt-get install syncthing
  echo -e "${GREEN}[INFO] - Syncthing installation completed successfully.${NO_COLOR}"
}

install_mscorefonts () {
  echo -e "${GREEN}[INFO] - Installing Microsoft Core Fonts... Wait for EULA agreement.${NO_COLOR}"
  sudo apt install ttf-mscorefonts-installer -y
}

# Android Studio
add_android_sdk () {
echo -e "${GREEN}[INFO] - Adding Android SDK to the PATH...${NO_COLOR}"
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_HOME/tools' >> ~/.bashrc
}

# download_jetbrains_toolbox () {
#   echo -e "${GREEN}[INFO] - Downloading JetBrains Toolbox...${NO_COLOR}"
#   wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.3.2.31487.tar.gz -P $HOME/Downloads
#   ## Extract the downloaded file
#   echo -e "${GREEN}[INFO] - Extracting the downloaded file...${NO_COLOR}"
#   tar -xvf $HOME/Downloads/jetbrains-toolbox-2.3.2.31487.tar.gz -C $HOME/Downloads
#   ## Run the JetBrains Toolbox and making it executable
#   echo -e "${GREEN}[INFO] - Making JetBrains Toolbox executable...${NO_COLOR}"
#   chmod +x $HOME/Downloads/jetbrains-toolbox-2.3.2.31487/jetbrains-toolbox
#   echo -e "${GREEN}[INFO] - Running JetBrains Toolbox...${NO_COLOR}"
#   $HOME/Downloads/jetbrains-toolbox-2.3.2.31487/jetbrains-toolbox
# }

#----# Execution #----#
install_apt_packages
update_repositories
install_flatpak
download_deb_packages
#install_surfshark
install_protonvpn
install_syncthing
upgrade_cleanup
install_mscorefonts
add_android_sdk
