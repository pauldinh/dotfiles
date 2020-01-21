#!/bin/bash

cwd=$(pwd)

# dependencies
sudo apt install build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev

# optional dependencies
sudo apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev

#cd /tmp
#wget https://github.com/polybar/polybar/releases/download/3.4.2/polybar-3.4.2.tar
# run build.sh helper script in polybar directory. say Y to all prompts

cd ${cwd}
