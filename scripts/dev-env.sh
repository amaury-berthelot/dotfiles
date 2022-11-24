#!/usr/bin/bash

# will have some manually installed binaries (e.g. nvm, node, npm)
mkdir -p $HOME/.devenv/apps
# will have some shared configs (e.g. Neovim plugins)
mkdir -p $HOME/.devenv/share

docker run --rm -it \
  -v $HOME/.dotfiles:/home/dev/configs \
  -v $HOME/.devenv:/home/dev/.local \
  -v $(pwd):/home/dev/workspace \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY \
  localhost/images/dev-env \
  zsh
