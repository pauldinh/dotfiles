"""" vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'alok/notational-fzf-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/space-vim-theme'
Plug 'liuchengxu/eleline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'cespare/vim-toml'
Plug 'rhysd/devdocs.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
" highlights characters used to quickly skip around using `f` and `F`
Plug 'unblevable/quick-scope'
" use ctrl-hjkl to seamlessly navigate vim/tmux panes within tmux sessions
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

runtime settings.vimrc
runtime settings-syntax.vimrc

runtime ctags.vimrc
runtime devdocs.vimrc
runtime eleline.vimrc
runtime fzf.vimrc
runtime notational-fzf.vimrc
runtime space-vim-theme.vimrc
runtime vim-easy-align.vimrc
runtime xmllint.vimrc
