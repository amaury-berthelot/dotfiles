source ../utils.sh

mkdir -p lib/
wget -O lib/git-prompt.sh https://raw.githubusercontent.com/git/git/v2.37.1/contrib/completion/git-prompt.sh
wget -O lib/fzf-keybindings.sh https://raw.githubusercontent.com/junegunn/fzf/0.30.0/shell/key-bindings.zsh

create_folder_if_not_exists ../local/
create_folder_if_not_exists ../local/zsh/

create_file_if_not_exists ../local/zsh/zshrc
