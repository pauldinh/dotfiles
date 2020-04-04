#!/bin/bash

# latest git
sudo add-apt-repository ppa:git-core/ppa
sudo apt update
sudo apt install git

# diff-so-fancy (git)
ln -s ${HOME}/dotfiles/git/diff-so-fancy ${HOME}/.local/bin/diff-so-fancy # TODO a921

# gitconfig
# copy gitconfig instead of symlink cause default email may change
ln -s ${HOME}/dotfiles/git/gitconfig ${HOME}/.gitconfig # TODO a921
ln -s ${HOME}/dotfiles/git/gitignore_global ${HOME}/.gitignore_global # TODO a921

# gitconfig links to separate git-user file
# cp git-user file instead of symlink since this could change based on context
cp ${HOME}/dotfiles/git/git-user ${HOME}/.git-user
