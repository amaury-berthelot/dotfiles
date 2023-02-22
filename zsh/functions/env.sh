#!/usr/bin/sh

function ,env {
  if [[ -f .env.sh ]]; then
    source .env.sh
  fi

  if [[ -f .env ]]; then
    export $(cat .env | xargs)
  fi

  if [[ -f .nvmrc ]] && [[ "$(command -v nvm)" != "" ]]; then
    nvm use
  fi
}
