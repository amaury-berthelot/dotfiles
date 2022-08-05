Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" shortcuts
" " search file
nnoremap <leader>sf :GFiles<CR>
" " search text
nnoremap <leader>ss :Rg<CR>
" " search tag
nnoremap <leader>st :Tags<CR>
