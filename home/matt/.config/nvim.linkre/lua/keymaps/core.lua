-- vim.keymap.set('n', '<Space>', 'za', { silent = true })
-- vim.keymap.set('v', '<Space>', 'zf', { silent = true })
vim.keymap.set('n', '<Leader>h', ':set invhls<CR>', { silent = true })
vim.keymap.set('x', '.', ':norm.<CR>', { silent = true })
vim.keymap.set('n', '<Leader>f', ':lua require("fzf-lua").files()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rg', ':lua require("fzf-lua").live_grep({ })<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rrg', ':lua require("fzf-lua").live_grep_resume({ })<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>o', ':only<CR>', { silent = true })
vim.keymap.set('n', '<Leader>c', ':cclose<CR>', { silent = true })
vim.keymap.set('v', '<Leader>y', '"+y', { silent = true })

-- vim-test configuration: Sets the strategy for running tests (No default)
vim.g['test#strategy'] = 'tslime'
vim.keymap.set('n', '<Leader>t', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', '<Leader>T', ':TestSuite<CR>', { silent = true })

-- copilot
--vim.keymap.set('i', '<C-a>', 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true })

-- Fugitive mappings: Shortcuts for Git operations (No defaults)
vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>', { silent = true })
vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit<CR>', { silent = true })

vim.keymap.set('n', '<Leader>b', ':call ToggleNumbers()<CR>', { silent = true })
vim.keymap.set('n', '<Leader>r', ':call Background_transparent()<CR>', { silent = true })

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- jump directly to a specific pane
for i = 1, 9 do
  vim.keymap.set('n', '<Leader>' .. i, i .. '<C-w>w', { desc = "Move to window " .. i })
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gdd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gdv', ':vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gii', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'giv', ':vsplit<CR><cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'grv', ':vsplit<CR><cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
