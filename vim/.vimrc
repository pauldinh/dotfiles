"""" vim-plug
call plug#begin('~/.config/nvim/plugged')

" this guy is awesome
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'junegunn/limelight.vim'
"Plug 'junegunn/goyo.vim'

" can't not use this theme
Plug 'liuchengxu/space-vim-theme'
Plug 'liuchengxu/eleline.vim'

" highlights characters used to quickly skip around using `f` and `F`
Plug 'unblevable/quick-scope'

" comments eh, need to use this more
Plug 'scrooloose/nerdcommenter'

" note taking over 9000
Plug 'alok/notational-fzf-vim'

" use ctrl-hjkl to seamlessly navigate vim/tmux panes within tmux sessions
Plug 'christoomey/vim-tmux-navigator'

" git vim integration.. rarely use this but it looks powerful
Plug 'tpope/vim-fugitive'

call plug#end()

" show tabs and trailing spaces
" this *has* to be set before `expandtab` is or the tabs won't show
set list listchars=tab:▸\ ,trail:_

" convert tabs to 4 spaces
set tabstop=4 shiftwidth=4 expandtab

" relative line numbers cause math is hard
set number relativenumber cursorline

" visually wrap long lines but don't insert newlines into them
set wrap textwidth=0

syntax on
"au BufNewFile,BufRead *.launch set filetype=xml
au BufReadPost *.launch set syntax=xml
au BufReadPost *.inc set syntax=cpp

" indent yaml files with 2 spaces instead of 4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" set this so regular yanks go to system clipboard
set clipboard=unnamedplus

" scrolloff=20 attempts to show 20 lines above/below the cursor
set so=20

" should be default, but just in case
set ruler

" clear last search highlighting
map <Space> :noh<cr>

" ignores line numbers when selecting text with mouse
set mouse=a

" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"" fzf
"nnoremap <C-p> :Files ~/ws/aquanaut/src<Cr>
"nnoremap <C-g> :Rg<Cr>

" customize fzf statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
"
"
" cya arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" space-vim-dark theme
set background=dark
colorscheme space_vim_theme
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi Comment guifg=#5C6370 ctermfg=59
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
let g:eleline_powerline_fonts = 1
set laststatus=2


" notational velocity
let g:nv_search_paths = ['~/notes']
let g:nv_use_short_pathnames = 1

" goyo + limelight, nice writing
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!
"let g:limelight_conceal_ctermfg = 240
"let g:limelight_conceal_guifg = '#777777'
