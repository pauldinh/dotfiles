#!/bin/bash

cwd=$(pwd)

sudo apt install flatpak
flatpak install flathub com.spotify.Client

# spice up spotify
cd /tmp
wget https://github.com/khanhas/spicetify-cli/releases/download/v0.9.7/spicetify-0.9.7-linux-amd64.tar.gz
tar zxvf spicetify-0.9.7-linux-amd64.tar.gz -C ~/.spicetify
ln -s ~/.spicetify/spicetify $HOME/.local/bin

# themes
git clone https://github.com/morpheusthewhite/spicetify-themes.git ~/.spicetify-themes --depth 1
cp -r ~/.spicetify-themes/* ~/.config/spicetify/Themes

cd ${cwd}
