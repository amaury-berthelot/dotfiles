#!/bin/bash

CONFIGS_FOLDER=$HOME/.dotfiles

function create_folder_if_not_exists {
  if [[ ! -d $1 ]] && [[ ! -f $1 ]]; then
    mkdir $1
  fi
}

function create_file_if_not_exists {
  if [[ ! -d $1 ]] && [[ ! -f $1 ]]; then
    touch $1
  fi
}

function append_to_file_if_exists {
  if [[ -f $1 ]] && [[ -f $2 ]]; then
    cat $1 >> $2
  fi
}

function symlink_file_if_not_exists {
  if [[ -f $1 ]] && [[ -d $(dirname $2) ]] && [[ ! -d $2 ]] && [[ ! -f $2 ]]; then
    ln -s $1 $2
  fi
}

function copy_file_if_not_exists {
  if [[ -f $1 ]] && [[ -d $(dirname $2) ]] && [[ ! -d $2 ]] && [[ ! -f $2 ]]; then
    cp $1 $2
  fi
}

function symlink_folder_if_not_exists {
  if [[ -d $1 ]] && [[ -d $(dirname $2) ]] && [[ ! -d $2 ]] && [[ ! -f $2 ]]; then
    ln -s $1 $2
  fi
}

function move_file_if_exists {
  if [[ -f $1 ]]; then
    mv $1 $2
  fi
}

function move_folder_if_exists {
  if [[ -d $1 ]]; then
    mv $1 $2
  fi
}

function backup_if_exists {
  create_folder_if_not_exists $CONFIGS_FOLDER/backup/
  move_file_if_exists $1 $CONFIGS_FOLDER/backup/$(basename $1)
  move_folder_if_exists $1 $CONFIGS_FOLDER/backup/$(basename $1)
}

function try_backup_and_setup_file {
  backup_if_exists $2
  symlink_file_if_not_exists $1 $2
}


function try_backup_and_setup_folder {
  backup_if_exists $2
  symlink_folder_if_not_exists $1 $2
}
