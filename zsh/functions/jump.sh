#!/bin/sh

function ,jump() {
  local DATA_PATH="$HOME/.jump_locations.sh"
  local HISTORY_PATH="$HOME/.jump_history"

  # Add ~/.jump_locations.sh with entries like
  # local docs=/home/me/Documents

  if [ $# -eq 1 ]; then
    if [ -f $DATA_PATH ]; then
      source $DATA_PATH
      local target="${(P)1}"

      if [[ -f $HISTORY_PATH ]] && [[ $1 == '$' ]]; then
        ,clear_env
        cd $(cat $HISTORY_PATH | sort | uniq | fzf)
        ,env
      elif [[ $target != "" ]]; then
        ,clear_env
        cd $target
        ,env
      else
        ,clear_env
        cd $1
        pwd >> $HISTORY_PATH
        cat $HISTORY_PATH | sort | uniq > $HISTORY_PATH
        ,env
      fi
    else
      echo "no jump locations"
    fi
  elif [[ $# -eq 2 ]] && [[ $1 == "add" ]]; then
    echo "local $2=$(pwd)" >> $DATA_PATH
  else
    ,clear_env
    cd
    ,env
  fi
}

