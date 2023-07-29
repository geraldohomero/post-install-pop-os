#!/usr/bin/env bash
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'
#-----------https://github.com/geraldohomero/-------------#
#----------https://geraldohomero.github.io/---------------#

#------------Um projeto de script pessoal-----------------#

DIRETORIO_DOWNLOAD_PROGRAMAS="$HOME/Downloads/Programas"
PROGRAMAS_PARA_INSTALAR_DEB=(
  http://iriun.gitlab.io/iriunwebcam-2.3.1.deb
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
  audacity
  git
  gitkraken
  steam
)
PROGRAMAS_PARA_INSTALAR_FLATPAK=(
  com.bitwarden.desktop
  org.kde.okular
  org.zotero.Zotero
  com.heroicgameslauncher.hgl
  io.gitlab.librewolf-community
  com.microsoft.Edge
  org.gnome.Cheese
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
  curl -f https://downloads.surfshark.com/linux/debian-install.sh --output surfshark-install.sh #gets the installation script
  cat surfshark-install.sh #shows script's content
  sh surfshark-install.sh #installs surfshark
}

#----# Execução #----#
instalar_pacotes_apt
atualizacao_repositorios
instalar_flatpak
baixar_pacotes_debs
instala_surfshark
atualizacao_repositorios
upgrade_limpeza
