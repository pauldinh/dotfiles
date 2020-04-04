#!/bin/bash

# latest git
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git

# diff-so-fancy (git)
ln -s ${HOME}/dotfiles/git/diff-so-fancy ${HOME}/.local/bin/diff-so-fancy # TODO a921

# gitconfig
ln -s ${HOME}/dotfiles/git/gitconfig ${HOME}/.gitconfig # TODO a921
ln -s ${HOME}/dotfiles/git/gitignore_global ${HOME}/.gitignore_global # TODO a921
