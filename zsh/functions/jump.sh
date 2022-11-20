#!/bin/sh

function ,jump() {
  local DATA_PATH="$HOME/.jump_locations.sh"

  # Add ~/.jump_locations.sh with entries like
  # local docs=/home/me/Documents

  if [ $# -eq 1 ]; then
    if [ -f $DATA_PATH ]; then
      source $DATA_PATH
      local target="${(P)1}"

      if [ -n $target ]; then
        cd $target
      else
        echo "cannot jump"
      fi
    else
      echo "no jump locations"
    fi
  elif [[ $# -eq 2 ]] && [[ $1 == "add" ]]; then
    echo "local $2=$(pwd)" >> $DATA_PATH
  else
    echo "jump [add] <path>"
  fi
}

