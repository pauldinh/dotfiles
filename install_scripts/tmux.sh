#!/bin/bash

# get dependencies
sudo apt install libevent-dev libncurses5-dev urlview

# tmux
cwd=$(pwd)
cd /tmp
wget -P _tmux/ https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a.tar.gz
cd _tmux
tar xf tmux-3.0a.tar.gz
cd tmux-3.0a
./configure
make && sudo make install
cd ${cwd}

# tmuxifier
git clone https://github.com/jimeh/tmuxifier.git ${HOME}/.tmuxifier

# oh my tmux
git clone https://github.com/gpakosz/.tmux.git ${HOME}/.tmux
ln -sf ${HOME}/.tmux/.tmux.conf ~/.tmux.conf
ln -sf ${HOME}/dotfiles/tmux/.tmux.conf.local ${HOME}/.tmux.conf.local

# clone tpm plugins into .tmux: https://github.com/gpakosz/.tmux/pull/216
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
