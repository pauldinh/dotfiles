dotfiles
========

Thanks to John Anderson: http://sontek.net/blog/detail/turning-vim-into-a-modern-python-ide

quickstart
==========

* source `/path/to/dotfiles/bash/.bash_profile` in `~/.bashrc`
* `git config --global core.excludesfile /path/to/dotfiles/.gitignore_global`

For `tmux`, first get https://github.com/gpakosz/.tmux, and then, symlink its `.tmux.conf`, and then
* `ln -s /path/to/dotfiles/tmux/.tmux.conf.local ~/.tmux.conf.local`

alacritty
* `mkdir -p ~/.config/alacritty`
* `ln -s /path/to/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml`

neovim
* `mkdir -p ~/.config/nvim`
* `ln -s /path/to/dotfiles/vim/.vimrc ~/.config/nvim/init.vim`
