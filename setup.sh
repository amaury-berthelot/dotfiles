#!/bin/bash

source ./utils.sh

for item in ./*; do
  if [[ -f $item/setup.sh ]]; then
    cd $item
    ./setup.sh
    cd -
  fi
done

