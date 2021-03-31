#!/bin/bash

# neovim
cwd=$(pwd)

cd /tmp
curl -L https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage -o nvim
chmod +x nvim
sudo chown root:root nvim
sudo mv nvim /usr/local/bin
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 60

# vim-plug
curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# clipboard bs for ubuntu
sudo apt install xclip

cd $cwd
