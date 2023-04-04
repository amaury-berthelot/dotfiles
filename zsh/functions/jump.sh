#!/bin/sh

function ,jump() {
  local DATA_PATH="$HOME/.jump_locations.sh"
  local HISTORY_PATH="$HOME/.jump_history"

  # Add ~/.jump_locations.sh with entries like
  # local docs=/home/me/Documents

  if [[ $# -eq 0 ]]; then
    ,clear_env
    cd
    return
  fi

  local trigger_env_after_change=1
  if [[ $# -ge 1 ]] && [[ $1 == "!" ]]; then
    trigger_env_after_change=0
    shift
  fi

  if [[ $1 == "-" ]]; then
    cd -
    return
  fi

  if [[ -f $DATA_PATH ]]; then
    source $DATA_PATH
  fi

  if [[ $# -eq 2 ]] && [[ $1 == "add" ]]; then
    echo "local $2=$(pwd)" >> $DATA_PATH
    echo "$(pwd) added as $2"
    return
  fi

  local target="${(P)1}"

  if [[ $1 == "$" ]]; then
    ,clear_env
    cd $(cat $HISTORY_PATH | sort | uniq | fzf)
  elif [[ $target != "" ]]; then
    ,clear_env
    cd $target
  elif [[ -d $1 ]]; then
    ,clear_env
    cd $1
    pwd >> $HISTORY_PATH
  fi

  if [[ $trigger_env_after_change -eq 1 ]]; then
    ,env
  fi
}

