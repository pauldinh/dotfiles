#!/bin/bash

# get dependencies
sudo apt install libevent-dev libncurses5-dev urlview xsel

## tmux
#cwd=$(pwd)
#cd /tmp
#wget -P _tmux/ https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a.tar.gz
#cd _tmux
#tar xf tmux-3.0a.tar.gz
#cd tmux-3.0a
#./configure
#make && sudo make install
#cd ${cwd}

# tmux appimage instead of source
TMUX_VERSION=tmux3.1b
TMUX_BINARY=tmux-3.1b-x86_64.AppImage
cwd=$(pwd)
cd /tmp
wget https://github.com/nelsonenzo/tmux-appimage/releases/download/${TMUX_VERSION}/${TMUX_BINARY}
chmod +x ${TMUX_BINARY}
mkdir -p ${HOME}/applications/tmux
mv ${TMUX_BINARY} ${HOME}/applications/tmux
ln -sfv ${HOME}/applications/tmux/${TMUX_BINARY} ${HOME}/applications/tmux/tmux
cd ${cwd}

# tmuxifier
git clone https://github.com/jimeh/tmuxifier.git ${HOME}/.tmuxifier

# oh my tmux
git clone https://github.com/gpakosz/.tmux.git ${HOME}/.tmux
ln -sf ${HOME}/.tmux/.tmux.conf ~/.tmux.conf # TODO a921
ln -sf ${HOME}/dotfiles/tmux/tmux.conf.local ${HOME}/.tmux.conf.local # TODO a921

# clone tpm plugins into .tmux: https://github.com/gpakosz/.tmux/pull/216
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
