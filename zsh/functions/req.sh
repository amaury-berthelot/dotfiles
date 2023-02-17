#!/usr/bin/bash

EDITOR=nvim

function ,req {
  if [[ -z ${DATA_DIR} ]]; then
    echo "DATA_DIR is not defined"
    return
  fi

  cd $DATA_DIR

  local is_edition=false
  if [[ $1 == "edit" ]] || [[ $1 == "e" ]]; then
    is_edition=true
  fi

  local is_variable_edition=false
  if [[ $1 == "variables" ]] || [[ $1 == "var" ]] || [[ $1 == "v" ]]; then
    is_variable_edition=true
  fi

  local is_result_display=false
  if [[ $1 == "result" ]] || [[ $1 == "res" ]] || [[ $1 == "r" ]]; then
    is_result_display=true
  fi

  local request=""
  if [[ $is_variable_edition == false ]]; then
    request=$(find requests -type f | cut -d'/' -f2- | fzf);
  fi

  if $is_edition; then
    $EDITOR requests/$request;
  elif $is_variable_edition; then
    $EDITOR $DATA_DIR/variables.json
  elif $is_result_display; then
    eval jq "'.[\"$request\"].body'" $DATA_DIR/responses.json;
  else
    cp requests/$request requests/last
    python3 ~/.dotfiles/scripts/req.py $@ $request;
  fi

  cd - 1>/dev/null;
}
