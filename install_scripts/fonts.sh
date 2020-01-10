#!/bin/bash

cwd=$(pwd)

# powerline
cd /tmp
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh

# nerd-fonts
cd /tmp
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh

cd $cwd
