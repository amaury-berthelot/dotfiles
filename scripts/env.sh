#!/bin/bash

if [[ $1 == "create" ]] ; then
  if [[ $# -ne 4 ]]; then
    echo "$0 create <name> <image> <workspace>"
    exit 1
  else
    docker run -it --name $2 -v $4:/home/dev/workspace --network=host --user=dev $3 bash
    exit 0
  fi
elif [[ $1 == "start" ]]; then
  if [[ $# -ne 2 ]]; then
    echo "$0 start <name>"
    exit 1
  else
    docker start -ai $2
    exit 0
  fi
elif [[ $1 == "attach" ]]; then
  if [[ $# -ne 2 ]]; then
    echo "$0 attach <name>"
    exit 1
  else
    docker exec -it $2 bash
    exit 0
  fi
elif [[ $1 == "root" ]]; then
  if [[ $# -ne 2 ]]; then
    echo "$0 root <name>"
    exit 1
  else
    docker exec -it --user=root $2 bash
    exit 0
  fi
else
  echo "$0 <create|start|attach|root> <options>"
  exit 1
fi
