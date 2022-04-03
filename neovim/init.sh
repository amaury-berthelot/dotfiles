source ../utils.sh

create_folder_if_not_exists ../local/neovim/
copy_file_if_not_exists setup/init.vim ../local/neovim/init.vim
copy_file_if_not_exists setup/plugins.vim ../local/neovim/plugins.vim
