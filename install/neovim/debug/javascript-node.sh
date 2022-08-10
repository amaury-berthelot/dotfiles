#!/bin/bash

# See https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Javascript
mkdir -p ~/.local/misc/microsoft
git clone --depth 1 https://github.com/microsoft/vscode-node-debug2.git ~/.local/misc/microsoft/vscode-node-debug2
cd ~/.local/misc/microsoft/vscode-node-debug2
npm ci
NODE_OPTIONS=--no-experimental-fetch npm run build
