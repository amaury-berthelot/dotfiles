" to follow links without .md extension (like wikilinks)
au BufReadPost,BufNewFile *.md setlocal suffixesadd+=.md

" insert wikilink with fzf
inoremap <expr> <C-x><C-l> fzf#vim#complete(fzf#wrap({
      \ 'source': 'rg -n "^# "',
      \ 'reducer': { lines -> '[['.split(lines[0], '.md')[0].']] '.split(lines[0], '# ')[1] }
  \ }))
