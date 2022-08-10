lua << EOF
local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.local/misc/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}
EOF

function! DebugOpenScope()
lua << EOF
  local widgets = require('dap.ui.widgets')
  local my_sidebar = widgets.sidebar(widgets.scopes)
  my_sidebar.open()
EOF
endfunction

function! DebugOpenFrames()
lua << EOF
  local widgets = require('dap.ui.widgets')
  local my_sidebar = widgets.sidebar(widgets.frames)
  my_sidebar.open()
EOF
endfunction

function! DebugEvaluate()
lua << EOF
  require('dap.ui.widgets').hover()
EOF
endfunction

" shortcuts
nnoremap <leader>db :DapToggleBreakpoint<CR>
nnoremap <leader>dc :DapContinue<CR>
nnoremap <leader>di :DapStepInto<CR>
nnoremap <leader>do :DapStepOver<CR>
nnoremap <leader>dO :DapStepOut<CR>
nnoremap <leader>dt :DapTerminate<CR>
nnoremap <leader>dps :call DebugOpenScope()<CR>
nnoremap <leader>dpf :call DebugOpenFrames()<CR>
nnoremap <leader>dpe :call DebugEvaluate()<CR>
