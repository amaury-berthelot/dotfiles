#!/usr/bin/bash

# will have some manually installed binaries (e.g. nvm, node, npm)
mkdir -p $HOME/.devenv/apps
# will have some shared configs (e.g. Neovim plugins)
mkdir -p $HOME/.devenv/share

docker run \
  --rm \
  --network host \
  -v $HOME/.ssh:/home/dev/.ssh \
  -v $HOME/.dotfiles:/home/dev/configs \
  -v $HOME/.devenv/local:/home/dev/.local \
  -v $HOME/.devenv/config:/home/dev/.config \
  -v $HOME/.devenv/cache:/home/dev/.cache \
  -v $HOME/.devenv/vscode:/home/dev/.vscode \
  -v $HOME/.devenv/vscode:/home/dev/.vscode-oss \
  -v $HOME/.jump_locations.sh:/home/dev/.jump_locations.sh \
  -v $HOME/.jump_history:/home/dev/.jump_history \
  -v $(pwd):/home/dev/workspace \
  -v $(pwd):$(pwd) \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --group-add $(getent group docker | cut -d':' -f3) \
  -e DISPLAY \
  -it \
  --shm-size=1G\
  localhost/images/devenv zsh
