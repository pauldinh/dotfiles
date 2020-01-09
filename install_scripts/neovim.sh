#!/bin/bash

# neovim
wget -P debs/  https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage
chmod +x debs/nvim.appimage
sudo mv debs/nvim.appimage /usr/local/bin/nvim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 60
sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 60
sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 60

# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# mkdir for notational velocity (note taking)
mkdir -p ~/notes

# symlink .vimrc
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/vim/.vimrc ~/.config/nvim/init.vim

# clipboard bs for ubuntu
sudo apt install xclip
