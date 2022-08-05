source ../utils.sh

wget -O autoload/plug.vim https://github.com/junegunn/vim-plug/raw/0.11.0/plug.vim

create_folder_if_not_exists ../local/neovim/
copy_file_if_not_exists setup/init.vim ../local/neovim/init.vim
copy_file_if_not_exists setup/configs.vim ../local/neovim/configs.vim
