#!/bin/bash

cwd=$(pwd)

cd /tmp
curl -LO https://github.com/sharkdp/bat/releases/download/v0.18.0/bat_0.18.0_amd64.deb
sudo apt install ./bat_0.18.0_amd64.deb

cd ${cwd}
