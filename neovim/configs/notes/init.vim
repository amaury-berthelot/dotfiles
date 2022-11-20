" to follow links without .md extension (like wikilinks)
au BufReadPost *.md setlocal suffixesadd+=.md
au BufReadPost *.md set spell
au BufReadPost *.md setlocal spelllang=en

" insert wikilink with fzf
inoremap <expr> <C-x><C-w> fzf#vim#complete(fzf#wrap({
      \ 'source': 'rg -n "^# "',
      \ 'reducer': { lines -> '[['.split(lines[0], '.md')[0].']] '.split(lines[0], '# ')[1] }
  \ }))

command Fr :setlocal spelllang=fr
command En :setlocal spelllang=en
