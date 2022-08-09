function! LoadConfigs()
  let configs = json_decode(readfile($HOME . "/.dotfiles/local/neovim/configs.json"))
  
  " Load the plugins
  " (some configs depend on the plugins being loaded)
  call plug#begin()
    for config in configs
      if config['active']
        exe "source" . $HOME . "/.dotfiles/neovim/configs/" . config['id'] . "/plugins.vim"
      endif
    endfor
  call plug#end()

  " Initialize the config once the plugins are loaded
  for config in configs
    if config['active']
      exe "source" . $HOME . "/.dotfiles/neovim/configs/" . config['id'] . "/init.vim"
    endif
  endfor
endfunction

call LoadConfigs()
