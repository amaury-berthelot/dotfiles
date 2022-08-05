#!/bin/bash

source ../utils.sh

# if VSCodium
try_backup_and_setup_file $CONFIGS_FOLDER/vscode/settings.json $HOME/.config/VSCodium/User/settings.json
try_backup_and_setup_file $CONFIGS_FOLDER/vscode/keybindings.json $HOME/.config/VSCodium/User/keybindings.json
try_backup_and_setup_file $CONFIGS_FOLDER/vscode/tasks.json $HOME/.config/VSCodium/User/tasks.json

# if code-server
try_backup_and_setup_file $CONFIGS_FOLDER/vscode/settings.json $HOME/.local/share/code-server/User/settings.json
try_backup_and_setup_file $CONFIGS_FOLDER/vscode/keybindings.json $HOME/.local/share/code-server/User/keybindings.json
try_backup_and_setup_file $CONFIGS_FOLDER/vscode/tasks.json $HOME/.local/share/code-server/User/tasks.json

