#!/bin/bash

# StarDict command line dictionary
# https://dushistov.github.io/sdcv/
#
# $ sdcv <word>

cwd=$(pwd)

sudo apt install sdcv

DICTIONARY_PATH="/usr/share/stardict/dic"
WAYBACK_URL="https://web.archive.org/web/20140428003644/http://abloz.com/huzheng/stardict-dic/dict.org/"
#wget https://web.archive.org/web/20140428003644/http://abloz.com/huzheng/stardict-dic/dict.org/stardict-dictd_www.dict.org_wn-2.4.2.tar.bz2

function get_dict()
{
    wget ${WAYBACK_URL}/$1
    sudo tar xvjf $1 -C ${DICTIONARY_PATH}
}

sudo mkdir -p ${DICTIONARY_PATH}

cwd=$(pwd)

cd /tmp

# The Collaborative International Dictionary of English
get_dict stardict-dictd_www.dict.org_gcide-2.4.2.tar.bz2

# WordNet
get_dict stardict-dictd_www.dict.org_wn-2.4.2.tar.bz2

# Moby Thesaurus II
get_dict stardict-dictd-moby-thesaurus-2.4.2.tar.bz2

# Webster's Revised Unabridged Dictionary (1913)
get_dict stardict-dictd-web1913-2.4.2.tar.bz2

# free on-line dictionary of computing - http://foldoc.org/
get_dict stardict-dictd_www.dict.org_foldoc-2.4.2.tar.bz2

# jargon file - http://catb.org/jargon/html/online-preface.html
get_dict stardict-dictd-jargon-2.4.2.tar.bz2

# be nice and go back
cd $cwd
