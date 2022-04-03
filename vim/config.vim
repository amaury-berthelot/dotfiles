set autoindent
set expandtab
set hlsearch
set ignorecase
set incsearch
set nobackup
set nocompatible
set number
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

filetype on
filetype plugin on
filetype indent on
syntax on

nnoremap <SPACE> <Nop>
let mapleader=" "

let g:netrw_keepdir=0
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=20

autocmd BufNewFile,BufRead *.svelte set syntax=html
