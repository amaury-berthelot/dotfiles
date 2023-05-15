let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint']
      \ }
let g:ale_fixers = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'typescript': ['eslint', 'prettier']
      \ }
let g:ale_fix_on_save = 1

" shortcuts
nnoremap <leader>ljg :CocCommand tsserver.goToSourceDefinition<CR>

" misc
au BufReadPost *.svelte set syntax=html
