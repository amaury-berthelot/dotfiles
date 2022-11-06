#!/usr/bin/bash

source ../utils.sh

if [[ ! -f autoload/plug.vim ]]; then
  wget -O autoload/plug.vim https://github.com/junegunn/vim-plug/raw/0.11.0/plug.vim
fi

create_folder_if_not_exists ../local/vim/
copy_file_if_not_exists setup/init.vim ../local/vim/init.vim
copy_file_if_not_exists setup/configs.vim ../local/vim/configs.vim
