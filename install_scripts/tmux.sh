#!/bin/bash

# get dependencies
sudo apt install libevent-dev libncurses5-dev

# tmux
cwd=$(pwd)
wget -P _tmux/ https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a.tar.gz
cd _tmux
tar xf tmux-3.0a.tar.gz
cd tmux-3.0a
./configure
make && sudo make install
cd $cwd

# tmuxifier
git clone https://github.com/jimeh/tmuxifier.git ${HOME}/.tmuxifier

# oh my tmux
git clone https://github.com/gpakosz/.tmux.git ${HOME}/.tmux
ln -sf ${HOME}/.tmux/.tmux.conf ~/.tmux.conf
ln -sf ${HOME}/dotfiles/tmux/.tmux.conf.local ${HOME}/.tmux.conf.local
