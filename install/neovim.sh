#!/usr/bin/bash

VERSION=0.8.0
INSTALL_PATH=$HOME/.shared/neovim

if [[ ! -d $INSTALL_PATH/$VERSION ]]; then
  mkdir -p $INSTALL_PATH/$VERSION

  wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.tar.gz
  tar -C $INSTALL_PATH/$VERSION -xzf nvim-linux64.tar.gz
  rm nvim-linux64.tar.gz

  rm -f $INSTALL_PATH/current
  ln -s $INSTALL_PATH/$VERSION/nvim-linux64 $INSTALL_PATH/current
  chmod u+x $INSTALL_PATH/current/bin/nvim
fi

rm -f $HOME/bin/nvim
ln -s $INSTALL_PATH/current/bin/nvim $HOME/bin/nvim
