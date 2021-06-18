#!/bin/bash

# cheat
CHEAT_VERSION=4.2.0

cwd=$(pwd)

cd /tmp
wget https://github.com/cheat/cheat/releases/download/${CHEAT_VERSION}/cheat-linux-amd64.gz
gzip -d cheat-linux-amd64.gz
mv cheat-linux-amd64 cheat
chmod +x cheat
sudo chown root:root cheat
sudo mv cheat /usr/local/bin

cd $cwd
