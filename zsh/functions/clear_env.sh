#!/bin/sh

function ,clear_env {
  if [[ -f .env ]]; then
    for variable in $(cat .env | cut -d'=' -f1); do
      unset $variable
    done
  fi
}
