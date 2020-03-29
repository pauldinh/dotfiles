#!/bin/bash

ln -s ${HOME}/dotfiles/git-aware-prompt ${HOME}/.git-aware-prompt
echo 'source ${HOME}/.git-aware-prompt/main.sh' >> ${HOME}/.bashrc
