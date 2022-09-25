#!/bin/bash

source ../utils.sh

mkdir -p $HOME/.config/i3/
try_backup_and_setup_file $CONFIGS_FOLDER/i3/config $HOME/.config/i3/config

mkdir -p $HOME/.config/i3status/
try_backup_and_setup_file $CONFIGS_FOLDER/i3/i3status/config $HOME/.config/i3status/config
