#!/bin/bash

mkdir -p ~/.config/nvim
ln -sfv ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim # TODO a921

for FILE in ~/dotfiles/vim/*.vimrc ; do # TODO a921
    f=$(basename -- $FILE)
    ln -sfv $FILE ~/.config/nvim/$f
done
