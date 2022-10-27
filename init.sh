#!/bin/bash

source utils.sh

for item in ./*; do
  if [[ -f $item/init.sh ]]; then
    cd $item
    ./init.sh
    cd -
  fi
done
