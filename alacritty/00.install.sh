#!/bin/bash

cwd=$(pwd)

#cd /tmp
#wget https://github.com/alacritty/alacritty/releases/download/v0.4.2/Alacritty-v0.4.2-ubuntu_18_04_amd64.deb
#sudo apt-get install ./Alacritty-v0.4.2-ubuntu_18_04_amd64.deb

cd /tmp
git clone https://github.com/alacritty/alacritty.git
cd alacritty
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 gzip
cargo build --release

# post build

# terminfo
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# desktop entry
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# man page
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

# bash completion
mkdir -p ~/.bash_completion.d
cp extra/completions/alacritty.bash ~/.bash_completion.d/alacritty
#echo "source ~/.bash_completion/alacritty" >> ~/.bashrc

cd $cwd
