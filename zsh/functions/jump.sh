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

      if [[ $target != "" ]]; then
        cd $target
        ,env
      elif [[ -d $1 ]]; then
        cd $1
        pwd >> $HISTORY_PATH
        cat $HISTORY_PATH | sort | uniq > $HISTORY_PATH
        ,env
      else
        echo "cannot jump"
      fi
    else
      echo "no jump locations"
    fi
  elif [[ -f $HISTORY_PATH ]] && [[ $# -eq 0 ]]; then
    cd $(cat $HISTORY_PATH | sort | uniq | fzf)
    ,env
  elif [[ $# -eq 2 ]] && [[ $1 == "add" ]]; then
    echo "local $2=$(pwd)" >> $DATA_PATH
  else
    echo "jump [add] <path>"
  fi
}

