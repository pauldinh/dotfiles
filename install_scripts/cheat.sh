#!/bin/bash

# cheat
cd /tmp && \
wget https://github.com/cheat/cheat/releases/download/4.0.4/cheat-linux-amd64.gz && \
gzip -d cheat-linux-amd64.gz && \
chmod +x cheat-linux-amd64 && \
sudo mv cheat-linux-amd64 /usr/local/bin && \
sudo ln -sn /usr/local/bin/cheat-linux-amd64 /usr/local/bin/cheat
