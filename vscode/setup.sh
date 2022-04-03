#!/bin/bash

source ../utils.sh

try_backup_and_setup_file $CONFIGS_FOLDER/vscode/settings.json $HOME/.config/VSCodium/User/settings.json
try_backup_and_setup_file $CONFIGS_FOLDER/vscode/keybindings.json $HOME/.config/VSCodium/User/keybindings.json
try_backup_and_setup_file $CONFIGS_FOLDER/vscode/tasks.json $HOME/.config/VSCodium/User/tasks.json

