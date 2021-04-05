#!/bin/bash

# https://github.com/akavel/up - Ultimate Plumber, interactive pipes
cwd=$(pwd)
cd /tmp
wget https://github.com/akavel/up/releases/download/v0.4/up
chmod +x up
mkdir -p ${HOME}/applications/up
mv up ${HOME}/applications/up

mkdir -p ${HOME}/.local/bin
ln -sfv ${HOME}/applications/up/up ${HOME}/.local/bin

cd ${cwd}
