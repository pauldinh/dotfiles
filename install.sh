# create symlinks for .vim/ and .vimrc
echo 'This script will create symlinks for ~/.bash_profile, ~/.bash_aliases, ~/.gitignore_global, and ~/.config/terminator/config'
echo 'It will rename existing files to *.backup'
read -p 'Continue (y/n)? ' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo '\n'
    # remove previous settings
    mv ~/.gitignore_global ~/.gitignore_global.backup
    #mv ~/.config/terminator/config ~/.config/terminator/config.backup
    mv ~/.bash_aliases ~/.bash_aliases.backup
    mv ~/.tmux.conf ~/.tmux.conf.backup
    mv ~/.tmux/dev ~/.tmux/dev.backup
    mv ~/.vimrc ~/.vimrc.backup

    ln -s ${PWD}/.gitignore_global ~/.gitignore_global;

    git config --global core.excludesfile ~/.gitignore_global

    #mkdir -p ~/.config/terminator
    #ln -s ${PWD}/terminator/config ~/.config/terminator/config

    ln -s ${PWD}/.bash_aliases ~/.bash_aliases

    ln -s ${PWD}/.bash_profile ~/.bash_profile

    ln -s ${PWD}/tmux/.tmux.conf ~/.tmux.conf

    mkdir -p ~/.tmux
    ln -s ${PWD}/tmux/dev ~/.tmux/dev

    ln -s ${PWD}/vim/vimrc ~/.vimrc
    mkdir -p ~/.vim/colors
    ln -s ${PWD}/vim/space-vim-dark.vim ~/.vim/colors/space-vim-dark.vim
    mkdir -p ~/.config/nvim
    ln -s ${PWD}/vim/vimrc ~/.config/nvim/init.vim

    #mkdir -p ~/.config/termite
    #ln -s ${PWD}/termite/config ~/.config/termite/config

    ln -s ${PWD}/i3/i3status.conf ~/.i3status.conf

    mkdir -p ~/.config/i3
    ln -s ${PWD}/i3/config ~/.config/i3/config

    ln -s ${PWD}/compton/compton.conf ~/.config/compton.conf

    mkdir -p ~/.config/polybar
    ln -s ${PWD}/polybar/config ~/.config/polybar/config
    mkdir -p ~/.config/polybar
    ln -s ${PWD}/polybar/launch.sh ~/.config/polybar/launch.sh

    mkdir -p ~/.config/alacritty
    ln -s ${PWD}/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

    # tmux
    mkdir -p ~/.tmux-layouts
fi
