#!/usr/bin/bash

# will have some manually installed binaries (e.g. nvm, node, npm)
mkdir -p $HOME/.devenv/apps
# will have some shared configs (e.g. Neovim plugins)
mkdir -p $HOME/.devenv/share

docker run --rm -it -v $HOME/.dotfiles:/home/dev/configs -v $HOME/.devenv/apps:/home/dev/.local/apps -v $HOME/.devenv/share:/home/dev/.local/share -v $(pwd):/home/dev/workspace localhost/images/dev-env zsh
