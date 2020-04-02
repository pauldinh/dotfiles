#!/bin/bash

# StarDict command line dictionary
# https://dushistov.github.io/sdcv/

sudo apt install sdcv

sudo mkdir -p /usr/share/stardict/dic

cwd=$(pwd)

cd /tmp
wget https://web.archive.org/web/20140917131745/http://abloz.com/huzheng/stardict-dic/dict.org/stardict-dictd_www.dict.org_gcide-2.4.2.tar.bz2
sudo tar xvjf stardict-dictd_www.dict.org_gcide-2.4.2.tar.bz2 -C /usr/share/stardict/dic

wget https://web.archive.org/web/20140917131745/http://abloz.com/huzheng/stardict-dic/dict.org/stardict-dictd-jargon-2.4.2.tar.bz2
sudo tar xvjf stardict-dictd-jargon-2.4.2.tar.bz2 -C /usr/share/stardict/dic

cd $cwd
