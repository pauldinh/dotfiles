"""" vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/vim-easy-align'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'cespare/vim-toml'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
" highlights characters used to quickly skip around using `f` and `F`
Plug 'unblevable/quick-scope'
" use ctrl-hjkl to seamlessly navigate vim/tmux panes within tmux sessions
Plug 'christoomey/vim-tmux-navigator'
Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'honza/vim-snippets'
Plug 'sbdchd/neoformat'
call plug#end()

runtime settings.vimrc
runtime settings-syntax.vimrc

runtime ctags.vimrc
runtime fzf.vimrc
runtime lightline.vimrc
runtime vim-easy-align.vimrc
runtime aerojump.vimrc

" set themes last
runtime challenger-deep-theme.vimrc