nnoremap <leader>w :w<CR> " write
nnoremap <leader>q :q<CR> " close
nnoremap <leader>Q :qa<CR> " close all

" files
" " explorer
nnoremap <leader>fen :Lex<CR> " native explorer at root

" splits
nnoremap <leader>ss :sp<CR> " create horizontal
nnoremap <leader>sv :vs<CR> " create vertical
nnoremap <leader>sh <C-w>h " move left
nnoremap <leader>sj <C-w>j " move bottom
nnoremap <leader>sk <C-w>k " move top
nnoremap <leader>sl <C-w>l " move right

" tabs
nnoremap <leader>tn :tabe<CR> " create
nnoremap <leader>tc :tabclose<CR> "close
nnoremap <leader>tl :tabnext<CR> " go to next
nnoremap <leader>tL :tabprevious<CR> " go to previous
nnoremap <leader>th :tabprevious<CR> " go to previous

" navigation
nnoremap <leader>gfs <C-w>f " open file in horizontal split
nnoremap <leader>gfv <C-w>v " open file in vertical split
nnoremap <leader>gft <C-w>gf " open file in tab
nnoremap <leader>gfh gf " open file in current pane
