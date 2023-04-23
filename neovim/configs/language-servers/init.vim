lua << EOF
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>lldo', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>lldh', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>lldl', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>lldq', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>llgD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>llgd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>llk', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>llgi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>llwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>llwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>lll', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>llD', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>llr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>lla', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>llgr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>llf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- https://www.npmjs.com/package/typescript-language-server
require('lspconfig')['tsserver'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

-- https://www.npmjs.com/package/pyright
require('lspconfig')['pyright'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}

-- https://www.npmjs.com/package/svelte-language-server
require('lspconfig')['svelte'].setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
EOF

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
