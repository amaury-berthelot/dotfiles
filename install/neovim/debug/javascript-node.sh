#!/bin/bash

# See https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Javascript
mkdir -p ~/dev/microsoft
git clone --depth 1 https://github.com/microsoft/vscode-node-debug2.git ~/dev/microsoft/vscode-node-debug2
cd ~/dev/microsoft/vscode-node-debug2
npm ci
NODE_OPTIONS=--no-experimental-fetch npm run build
