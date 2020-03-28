#!/bin/bash

export ZATHURA_HOME=$HOME/src/zathura
mkdir -p $ZATHURA_HOME
wget -P $ZATHURA_HOME https://pwmt.org/projects/zathura/download/zathura-0.4.5.tar.xz
wget -P $ZATHURA_HOME https://pwmt.org/projects/zathura-pdf-poppler/download/zathura-pdf-poppler-0.3.0.tar.xz

cd $ZATHURA_HOME
tar xvf zathura-0.4.5.tar.xz
cd zathura-0.4.5
mkdir build && cd build
sudo apt install libgirara-gtk3-3
meson ..
ninja
sudo ninja install

cd $ZATHURA_HOME
tar xvf zathura-pdf-poppler-0.3.0.tar.xz
cd zathura-pdf-poppler-0.3.0
mkdir build && cd build
sudo apt install libpoppler-glib-dev
meson ..
ninja
sudo ninja install
