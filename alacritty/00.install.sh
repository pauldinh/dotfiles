#!/bin/bash

cwd=$(pwd)

cd /tmp
wget https://github.com/alacritty/alacritty/releases/download/v0.4.2/Alacritty-v0.4.2-ubuntu_18_04_amd64.deb
sudo apt-get install ./Alacritty-v0.4.2-ubuntu_18_04_amd64.deb

cd $cwd
