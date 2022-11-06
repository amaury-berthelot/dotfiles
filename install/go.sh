#!/bin/bash

VERSION=go1.18.3.linux-amd64
INSTALL_PATH=$HOME/.local/apps/go
SHELL_CONFIG_FILE=$HOME/.dotfiles/local/zsh/zshrc

if [[ ! -d $INSTALL_PATH/$VERSION ]]; then
  mkdir -p $INSTALL_PATH/$VERSION

  wget https://go.dev/dl/$VERSION.tar.gz
  tar -C $INSTALL_PATH/$VERSION -xzf $VERSION.tar.gz
  rm $VERSION.tar.gz

  rm -f $INSTALL_PATH/current
  ln -s $INSTALL_PATH/$VERSION/go $INSTALL_PATH/current

  echo "" >> $SHELL_CONFIG_FILE
  echo "# go" >> $SHELL_CONFIG_FILE
  echo 'export PATH=$PATH:'"$INSTALL_PATH/current/bin" >> $SHELL_CONFIG_FILE
fi
