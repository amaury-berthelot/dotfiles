#!/bin/bash

source ../utils.sh

try_backup_and_setup_file $CONFIGS_FOLDER/git/gitconfig $HOME/.gitconfig
try_backup_and_setup_file $CONFIGS_FOLDER/git/gitignore $HOME/.gitignore
