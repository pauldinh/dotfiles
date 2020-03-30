#!/bin/bash

cwd=$(pwd)

sudo apt install imagemagick
mkdir -p $HOME/src
cd $HOME/src
git clone https://github.com/stefanhaustein/TerminalImageViewer.git
cd TerminalImageViewer/src/main/cpp
make
sudo make install

cd ${cwd}
