#!/usr/bin/bash

function ,req {
  if [[ -z ${DATA_DIR} ]]; then
    echo "DATA_DIR is not defined"
    return
  fi

  cd $DATA_DIR

  local request=$(find requests -type f | cut -d'/' -f2- | fzf);

  if [[ $1 == "edit" ]] || [[ $1 == "e" ]]; then
    vim requests/$request;
  elif [[ $1 == "result" ]] || [[ $1 == "res" ]] || [[ $1 == "r" ]]; then
    eval jq "'.[\"$request\"].body'" $DATA_DIR/responses.json;
  else
    cp requests/$request requests/last
    python3 ~/.dotfiles/scripts/req.py $@ $request;
  fi

  cd - 1>/dev/null;
}
