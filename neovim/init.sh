source ../utils.sh

wget -O autoload/plug.vim https://github.com/junegunn/vim-plug/raw/0.11.0/plug.vim

create_folder_if_not_exists ../local/neovim/
create_file_if_not_exists ../local/neovim/init.vim
create_file_if_not_exists ../local/neovim/plugins.vim
copy_file_if_not_exists setup/configs.json ../local/neovim/configs.json
