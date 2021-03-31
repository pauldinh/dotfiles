#!/bin/bash

cwd=$(pwd)

cd /tmp
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo apt install ./ripgrep_12.1.1_amd64.deb

cd ${cwd}
