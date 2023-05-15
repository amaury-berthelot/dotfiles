" shortcuts
" " explorer
nnoremap <leader>fet :NERDTreeToggle<CR> " toggle
nnoremap <leader>fef :NERDTreeFind<CR> " focus current file

" override Mks command to close NERDTree before saving
" (they do not behave well on session restore)
command! Mks tabdo NERDTreeClose | mks!
