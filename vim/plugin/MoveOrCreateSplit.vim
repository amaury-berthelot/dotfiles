" Split shortcuts move or create split
" https://github.com/nicknisi/vim-workshop
function! MoveOrCreateSplit(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

map <C-h> :call MoveOrCreateSplit('h')<cr>
map <C-j> :call MoveOrCreateSplit('j')<cr>
map <C-k> :call MoveOrCreateSplit('k')<cr>
map <C-l> :call MoveOrCreateSplit('l')<cr>
