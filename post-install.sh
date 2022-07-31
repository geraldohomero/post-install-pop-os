#!/usr/bin/env bash
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'
#-----------https://github.com/geraldohomero/-------------#
#----------https://geraldohomero.github.io/---------------#

#------------Um projeto de script pessoal-----------------#
# PPA_LUTRIS="ppa:lutris-team/lutris"

DIRETORIO_DOWNLOAD_PROGRAMAS="$HOME/Downloads/Programas"
PROGRAMAS_PARA_INSTALAR_DEB=(
  https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb
  https://iriun.gitlab.io/iriunwebcam-2.6.deb
  https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megasync-xUbuntu_22.04_amd64.deb
  https://mega.nz/linux/repo/xUbuntu_22.04/amd64/nautilus-megasync-xUbuntu_22.04_amd64.deb
  https://ocean.surfshark.com/debian/pool/main/s/surfshark-release/surfshark-release_1.0.0-2_amd64.deb
)
PROGRAMAS_PARA_INSTALAR_APT=(
  htop
  neofetch
  openjdk-8-jre
  libreoffice-java-common
  virtualbox
  lutris
  codium
)
PROGRAMAS_PARA_INSTALAR_FLATPAK=(
  com.bitwarden.desktop
  org.kde.okular
  net.cozic.joplin_desktop
  org.zotero.Zotero
  fr.romainvigier.MetadataCleaner
  org.gnome.Cheese
  com.github.debauchee.barrier
  com.github.tenderowl.frog
  io.freetubeapp.FreeTube
  org.freeplane.App
  org.gnome.Characters
  com.github.tchx84.Flatseal
  net.davidotek.pupgui2
  io.github.antimicrox.antimicrox
  com.rafaelmardojai.Blanket
  com.usebottles.bottles
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
  sudo flatpak update
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

# add_ppa () {
#  echo -e "${VERDE}[INFO] - Adicionando PPAs...${SEM_COR}"
#  sudo add-apt-repository "$PPA_LUTRIS" -y &> /dev/null
#  atualizacao_repositorios
#}

atualizacao_repositorios () {
  echo -e "${VERDE}[INFO] - Atualizando repositórios...${SEM_COR}"
  sudo apt update &> /dev/null
}

instalar_flatpak () {
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
  [[ ! -d "$DIRETORIO_DOWNLOAD_PROGRAMAS" ]] && mkdir "$DIRETORIO_DOWNLOAD_PROGRAMAS"
  for url in ${PROGRAMAS_PARA_INSTALAR_DEB[@]}; do
    url_extraida=$(echo -e ${url##*/} | sed 's/-/_/g' | cut -d _ -f 1)
    if ! dpkg -l | grep -iq $url_extraida; then
      echo -e "${VERDE}[INFO] - Baixando o arquivo $url_extraida...${SEM_COR}"
      wget -c "$url" -P "$DIRETORIO_DOWNLOAD_PROGRAMAS" &> /dev/null
      echo -e "${VERDE}[INFO] - Instalando $url_extraida...${SEM_COR}"
      sudo dpkg -i $DIRETORIO_DOWNLOAD_PROGRAMAS/${url##*/} &> /dev/null
      echo -e "${VERDE}[INFO] - Instalando dependências...${SEM_COR}"
      sudo apt -f install -y &> /dev/null
    else
      echo -e "${VERDE}[INFO] - O programa $url_extraida já está instalado.${SEM_COR}"
    fi
  done
}

#----# Execução #----#
instalar_pacotes_apt
atualizacao_repositorios
instalar_flatpak
baixar_pacotes_debs
atualizacao_repositorios
upgrade_limpeza
