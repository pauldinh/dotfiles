#!/bin/bash

cwd=$(pwd)

cd /tmp
curl -LO https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd-musl_0.20.1_amd64.deb
sudo apt install ./lsd-musl_0.20.1_amd64.deb

cd ${cwd}
