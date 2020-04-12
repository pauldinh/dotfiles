#!/bin/bash

mkdir -p ${HOME}/.config/nvim
ln -sf ${HOME}/dotfiles/vim/init.vim ${HOME}/.config/nvim/init.vim # TODO a921

for FILE in ${HOME}/dotfiles/vim/*.vimrc ; do # TODO a921
    f=$(basename -- $FILE)
    ln -sf $FILE ${HOME}/.config/nvim/$f
done
