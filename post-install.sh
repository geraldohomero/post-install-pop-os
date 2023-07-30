#!/usr/bin/env bash
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'
#-----------https://github.com/geraldohomero/-------------#
#----------https://geraldohomero.github.io/---------------#
#------------Um projeto de script pessoal-----------------#

DIRETORIO_DOWNLOAD_PROGRAMAS="$HOME/Downloads/Programas"
PROGRAMAS_PARA_INSTALAR_DEB=(
  https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megasync-xUbuntu_22.04_amd64.deb
  https://mega.nz/linux/repo/xUbuntu_22.04/amd64/nautilus-megasync-xUbuntu_22.04_amd64.deb
)
PROGRAMAS_PARA_INSTALAR_APT=(
  btop
  neofetch
  openjdk-8-jre
  libreoffice-java-common
  virtualbox
  vim
  git
  steam
)
PROGRAMAS_PARA_INSTALAR_FLATPAK=(
  com.bitwarden.desktop
  org.kde.okular
  org.zotero.Zotero
  com.heroicgameslauncher.hgl
  io.gitlab.librewolf-community
  com.microsoft.Edge
  com.axosoft.GitKraken
  com.stremio.Stremio
  com.simplenote.Simplenote
  md.obsidian.Obsidian 
  org.gnome.Characters
  com.github.tchx84.Flatseal
  io.missioncenter.MissionCenter
)

#--------------Validações-------------#
# Internet?
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet verificada.${SEM_COR}"
fi

# wget está instalado? #
if [[ ! -x $(which wget) ]]; then
  echo -e "${VERMELHO}[ERRO] - O programa wget não está instalado.${SEM_COR}"
  echo -e "${VERDE}[INFO] - Instalando wget...${SEM_COR}"
  sudo apt install wget -y &> /dev/null
else
  echo -e "${VERDE}[INFO] - O programa wget já está instalado.${SEM_COR}"
fi

# Updates e upgrades #
upgrade_limpeza () {
  echo -e "${VERDE}[INFO] - Fazendo upgrade e limpeza...${SEM_COR}"
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

# Instalando pacotes e programas #
instalar_pacotes_apt () {
  for programa in ${PROGRAMAS_PARA_INSTALAR_APT[@]}; do
    if ! dpkg -l | grep -q $programa; then
      echo -e "${VERDE}[INFO] - Instalando o $programa...${SEM_COR}"
      sudo apt install $programa -y &> /dev/null
    else
      echo -e "${VERDE}[INFO] - O pacote $programa já está instalado.${SEM_COR}"
    fi
  done
}

atualizacao_repositorios () {
  echo -e "${VERDE}[INFO] - Atualizando repositórios...${SEM_COR}"
  sudo apt update &> /dev/null
}

instalar_flatpak () {
  # Adiciona repositório Flathub
  if ! flatpak remote-list | grep -q "flathub"; then
    echo -e "${VERDE}[INFO] - Adicionando o repositório Flathub...${SEM_COR}"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  else
    echo -e "${VERDE}[INFO] - O repositório Flathub já está adicionado.${SEM_COR}"
  fi
  # Instala flatpak
  for programa in ${PROGRAMAS_PARA_INSTALAR_FLATPAK[@]}; do
    if ! flatpak list | grep -q $programa; then
      echo -e "${VERDE}[INFO] - Instalando $programa...${SEM_COR}"
      flatpak install flathub $programa -y
    else
      echo -e "${VERDE}[INFO] - O flatpak $programa já está instalado.${SEM_COR}"
    fi
  done
}

baixar_pacotes_debs () {
  # Adiciona o diretório para downloads, se não existir
  [[ ! -d "$DIRETORIO_DOWNLOAD_PROGRAMAS" ]] && mkdir "$DIRETORIO_DOWNLOAD_PROGRAMAS"

  for url in "${PROGRAMAS_PARA_INSTALAR_DEB[@]}"; do
    nome_pacote=$(basename "$url")
    caminho_destino="$DIRETORIO_DOWNLOAD_PROGRAMAS/$nome_pacote"

    echo -e "${VERDE}[INFO] - Baixando pacote a partir do URL: $url${SEM_COR}"
    wget -c "$url" -P "$DIRETORIO_DOWNLOAD_PROGRAMAS" &> /dev/null

    echo -e "${VERDE}[INFO] - Instalando pacote: $nome_pacote${SEM_COR}"
    sudo dpkg -i "$caminho_destino"
    sudo apt -f install -y &> /dev/null
  done
}

instala_surfshark () {
  echo -e "${VERDE}[INFO] - Baixando o script de instalação do Surfshark VPN...${SEM_COR}"
  curl -f https://downloads.surfshark.com/linux/debian-install.sh --output surfshark-install.sh

  echo -e "${VERDE}[INFO] - Script de instalação baixado. Exibindo o conteúdo do script:${SEM_COR}"
  cat surfshark-install.sh

  echo -e "${VERDE}[INFO] - Executando o script de instalação do Surfshark VPN...${SEM_COR}"
  sh surfshark-install.sh

  # Check if the installation was successful
  if dpkg -l | grep -q "surfshark"; then
    echo -e "${VERDE}[INFO] - Surfshark VPN foi instalado com sucesso.${SEM_COR}"
  else
    echo -e "${VERMELHO}[ERROR] - Ocorreu um erro durante a instalação do Surfshark VPN.${SEM_COR}"
  fi
}

instala_syncthing () {
  # Add the release PGP keys
  echo -e "${VERDE}[INFO] - Adding the release PGP keys...${SEM_COR}"
  sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
  # Add the stable channel to APT sources
  echo -e "${VERDE}[INFO] - Adding the \"stable\" channel to APT sources...${SEM_COR}"
  echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
  # Add the candidate channel to APT sources
  echo -e "${VERDE}[INFO] - Adding the \"candidate\" channel to APT sources...${SEM_COR}"
  echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing candidate" | sudo tee -a /etc/apt/sources.list.d/syncthing.list
  # Update APT
  echo -e "${VERDE}[INFO] - Updating APT...${SEM_COR}"
  sudo apt update &> /dev/null
  # Install Syncthing
  echo -e "${VERDE}[INFO] - Installing Syncthing...${SEM_COR}"
  sudo apt-get install syncthing
  echo -e "${VERDE}[INFO] - Syncthing installation completed successfully.${SEM_COR}"
}

#----# Execução #----#
instalar_pacotes_apt
atualizacao_repositorios
instalar_flatpak
baixar_pacotes_debs
instala_surfshark
instala_syncthing
upgrade_limpeza
