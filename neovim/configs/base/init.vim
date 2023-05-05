set autoindent
set expandtab
set hlsearch
set ignorecase
set incsearch
set nobackup
set nocompatible
set number
set wrap
set scrolloff=10
set shiftwidth=2
set shiftwidth=2
set showcmd
set showmatch
set showmode
set smartcase
set splitbelow
set splitright
set tabstop=2
set wildignore=*.jpg,*.jpeg,*.png,*.pdf
set wildmenu
set wildmode=list:longest
set foldmethod=indent
set termguicolors
set relativenumber

filetype on
filetype plugin on
filetype indent on
syntax on

nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap o o<esc>
nnoremap O O<esc>

nnoremap £ ^

nnoremap <C-up> <C-w>+
nnoremap <C-right> <C-w>>
nnoremap <C-down> <C-w>-
nnoremap <C-left> <C-w><

inoremap jj <esc>
inoremap jk <esc>

" write
nnoremap <leader>w :w<CR>
" close
nnoremap <leader>q :q<CR>
" close and delete buffer
nnoremap <leader>Q :bd!<CR>

" native explorer
let g:netrw_keepdir=0
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=20
" " native explorer at root
nnoremap <leader>fenr :Lex<CR>
" " native explorer at current file
nnoremap <leader>fenf :Lex %:p:h<CR>

" splits
" " create horizontal
nnoremap <leader>ss :sp<CR>
" " create vertical
nnoremap <leader>sv :vs<CR>
" " move left
nnoremap <leader>sh <C-w>h
" " move bottom
nnoremap <leader>sj <C-w>j
" " move top
nnoremap <leader>sk <C-w>k
" " move right
nnoremap <leader>sl <C-w>l

" tabs
" " create
nnoremap <leader>tn :tabe<CR>
" "close
nnoremap <leader>tc :tabclose<CR>
" " go to next
nnoremap <leader>tl :tabnext<CR>
" " go to previous
nnoremap <leader>tL :tabprevious<CR>
" " go to previous
nnoremap <leader>th :tabprevious<CR>

" navigation
" " open file in horizontal split
nnoremap <leader>gfs <C-w>f
" " open file in vertical split
nnoremap <leader>gfv <C-w>v
" " open file in tab
nnoremap <leader>gft <C-w>gf
" " open file in current pane
nnoremap <leader>gfh gf
" " go to tag definition
nnoremap <leader>gtd <C-]>
