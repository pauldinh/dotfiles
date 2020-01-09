#!/bin/bash

cwd=$(pwd)

cd /tmp
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd /tmp
rm -rf fonts

cd $cwd

