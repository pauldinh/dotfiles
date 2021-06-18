#!/bin/bash

if [ -f ~/dotfiles/bash/bashrc ]; then # TODO a921

    if [ -f ~/.bashrc ]; then
        cp ~/.bashrc ~/.bashrc_old
    fi

    cp ~/dotfiles/bash/bashrc ~/.bashrc # TODO a921
fi

if [ -f ~/dotfiles/bash/profile ]; then # TODO a921

    if [ -f ~/.profile ]; then
        cp ~/.profile ~/.profile_old
    fi

    cp ~/dotfiles/bash/profile ~/.profile # TODO a921
fi

mkdir ~/.bash_logs
