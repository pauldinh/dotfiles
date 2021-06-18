#!/bin/bash

cwd=$(pwd)

cd /tmp
git clone https://github.com/facebook/PathPicker.git -b 0.9.2
cd PathPicker/debian
./package.sh
cd ..

sudo apt install ./fpp_0.9.2_noarch.deb

cd $cwd
