" general settings not associated with a particular plugin/program
"
" show tabs and trailing spaces
" this *has* to be set before `expandtab` is or the tabs won't show
set list listchars=tab:▸\ ,trail:_

" convert tabs to 4 spaces
set tabstop=4 shiftwidth=4 expandtab

" relative line numbers cause math is hard
set number relativenumber cursorline

" visually wrap long lines but don't insert newlines into them
set wrap textwidth=0

" indent yaml files with 2 spaces instead of 4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" set this so regular yanks go to system clipboard
set clipboard=unnamedplus

" scrolloff=20 attempts to show 20 lines above/below the cursor
set so=30

" should be default, but just in case
set ruler

" clear last search highlighting
map <Space> :noh<cr>

" ignores line numbers when selecting text with mouse
set mouse=a

" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" cya arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" saving file as root
cmap w!! %!sudo tee > /dev/null %
