source ../utils.sh

create_folder_if_not_exists ../local/vim/
copy_file_if_not_exists setup/init.vim ../local/vim/init.vim
copy_file_if_not_exists setup/plugins.vim ../local/vim/plugins.vim
