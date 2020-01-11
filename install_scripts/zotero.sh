#!/bin/bash

cwd=$(pwd)

cd /tmp
wget https://download.zotero.org/client/release/5.0.81/Zotero-5.0.81_linux-x86_64.tar.bz2
sudo tar xf Zotero-5.0.81_linux-x86_64.tar.bz2 -C /opt
cd /opt/Zotero_linux-x86_64
sudo ./set_launcher_icon
ln -s /opt/Zotero_linux-x86_64/zotero.desktop ${HOME}/.local/share/applications/zotero.desktop

cd ${cwd}
