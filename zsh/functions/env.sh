#!/usr/bin/sh

function ,env {
  if [[ -f .env.sh ]]; then
    source .env.sh
  fi
}
