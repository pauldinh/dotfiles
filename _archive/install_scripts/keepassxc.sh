#!/bin/bash

# add PPA
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt update

sudo apt install keepassxc

# actually, little more work with appimage to have it as a Desktop Entry
## appimage
#cwd=$(pwd)
#
#cd /tmp
#KEEPASSXC_VERSION=2.6.4
#KEEPASSXC_BINARY=KeePassXC-2.6.4-x86_64.AppImage
#wget https://github.com/keepassxreboot/keepassxc/releases/download/${KEEPASSXC_VERSION}/${KEEPASSXC_BINARY}
#chmod +x ${KEEPASSXC_BINARY}
#mkdir -p ${HOME}/applications/keepassxc
#mv ${KEEPASSXC_BINARY} ${HOME}/applications/keepassxc
#ln -sfv ${HOME}/applications/keepassxc/${KEEPASSXC_BINARY} keepassxc
#
#cd $cwd
