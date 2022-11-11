#!/bin/bash

VERSION=0.39.1
INSTALL_PATH=$HOME/.local/apps/nvm
SHELL_CONFIG_FILE=$HOME/.dotfiles/local/zsh/zshrc

if [[ ! -d $INSTALL_PATH/$VERSION ]]; then
  mkdir -p $INSTALL_PATH/$VERSION

  wget https://github.com/nvm-sh/nvm/archive/refs/tags/v$VERSION.tar.gz
  tar -C $INSTALL_PATH/$VERSION -xzf v$VERSION.tar.gz
  rm v$VERSION.tar.gz

  rm -f $INSTALL_PATH/current
  ln -s $INSTALL_PATH/$VERSION/nvm-$VERSION $INSTALL_PATH/current

  echo "" >> $SHELL_CONFIG_FILE
  echo "# nvm" >> $SHELL_CONFIG_FILE
  echo "export NVM_DIR=$INSTALL_PATH/current" >> $SHELL_CONFIG_FILE
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> $SHELL_CONFIG_FILE
fi
