#!/bin/bash

mkdir -p ${HOME}/.config/nvim
ln -sfv ${HOME}/dotfiles/vim/init.vim ${HOME}/.config/nvim/init.vim # TODO a921

for FILE in ${HOME}/dotfiles/vim/*.vimrc ; do # TODO a921
    f=$(basename -- $FILE)
    ln -sfv $FILE ${HOME}/.config/nvim/$f
done
