## ProtonVPN

`protonvpn-cli ks --off`
***

## Zotero + LibreOffice

`sudo apt install openjdk-8-jre`

`sudo apt install libreoffice-java-common`

* * *

## Iriun WebCam:

`sudo rmmod v4l2loopback && sudo modprobe v4l2loopback exclusive_caps=1`
***

## Hugo

`hugo -t [theme-name]`
***

# Git

`git log`

`git log --oneline`

`git add .`

`git commit -m “comentário”`

`git push origin main`

`git pull --rebase`

`git checkout -b dev`  -  cria nova branch "chamada dev"

`git switch main`  -   volta pro branch principal

`git merge nomeDaNovaBranch`  "enviar de uma branch para outra"

`git submodule update --remote --merge`

`git submodule add -b main <url> public`

# Jellyfin

`wget -O - https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | sudo apt-key add -`

`echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | sudo tee /etc/apt/sources.list.d/jellyfin.list`

`sudo apt update`

`sudo apt install jellyfin`


