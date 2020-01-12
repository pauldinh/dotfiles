#!/bin/bash

# https://github.com/sharkdp - genius
wget -P debs/  https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb
wget -P debs/  https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb
wget -P debs/  https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb
wget -P debs/  https://github.com/sharkdp/hyperfine/releases/download/v1.9.0/hyperfine_1.9.0_amd64.deb
wget -P debs/  https://github.com/sharkdp/pastel/releases/download/v0.6.1/pastel_0.6.1_amd64.deb
wget -P debs/  https://github.com/sharkdp/hexyl/releases/download/v0.6.0/hexyl_0.6.0_amd64.deb
wget -P debs/  https://github.com/sharkdp/diskus/releases/download/v0.6.0/diskus_0.6.0_amd64.deb

sudo dpkg -i debs/*.deb
