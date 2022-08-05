Plug 'mfussenegger/nvim-dap'

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
