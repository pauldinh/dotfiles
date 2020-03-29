#!/bin/bash

echo "source ${HOME}/dotfiles/bash/.bash_profile" >> ${HOME}/.bashrc

# git-aware-prompt
mkdir -p ${HOME}/.bash && cd ${HOME}/.bash
git clone https://github.com/pauldinh/git-aware-prompt.git
echo "export GITAWAREPROMPT=~/.bash/git-aware-prompt" >> ${HOME}/.bashrc
echo 'source "${GITAWAREPROMPT}/main.sh"' >> ${HOME}/.bashrc

# diff-so-fancy (git)
ln -s ${HOME}/dotfiles/diff-so-fancy/diff-so-fancy ${HOME}/.local/bin/diff-so-fancy

# gitconfig
ln -s ${HOME}/dotfiles/.gitconfig ${HOME}/.gitconfig
ln -s ${HOME}/dotfiles/.gitignore_global ${HOME}/.gitignore_global
