#!/bin/sh

function jump() {
  local DATA_PATH="$HOME/.jump_locations.sh"

  # Add ~/.jump_locations.sh with entries like
  # local docs=/home/me/Documents

  if [ $# -eq 1 ]; then
    if [ -f $DATA_PATH ]; then
      source $DATA_PATH

      if [ -n "${!1}" ]; then
        cd "${!1}"
      else
        echo "cannot jump"
      fi
    else
      echo "no jump locations"
    fi
  else
    echo "jump <path>"
  fi
}
