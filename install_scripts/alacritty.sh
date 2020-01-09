#!/bin/bash

wget -P debs/  https://github.com/jwilm/alacritty/releases/download/v0.4.1/Alacritty-v0.4.1-ubuntu_18_04_amd64.deb
ln -sf ~/dotfiles/alacritty ~/.config/alacritty
