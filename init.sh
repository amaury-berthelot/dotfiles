#!/bin/bash

source utils.sh

if [[ $(pwd) != "$HOME/.dotfiles" ]]; then
  if [[ ! -f $HOME/.dotfiles ]] && [[ ! -d $HOME/.dotfiles ]]; then
    ln -s $(pwd) $HOME/.dotfiles
  else
    echo "$HOME/.dotfiles alreay exists"
  fi
fi

for item in ./*; do
  if [[ -f $item/init.sh ]]; then
    cd $item
    ./init.sh
    cd -
  fi
done
