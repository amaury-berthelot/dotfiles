let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 1

" shortcuts
nnoremap <leader>ljg :CocCommand tsserver.goToSourceDefinition<CR>

" misc
au BufReadPost *.svelte set syntax=html
