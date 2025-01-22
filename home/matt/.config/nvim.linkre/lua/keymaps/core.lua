vim.keymap.set('n', '<Leader>h', ':set invhls<CR>', { silent = true, desc = "Toggle highlights" })
vim.keymap.set('x', '.', ':norm.<CR>', { silent = true })
vim.keymap.set('n', '<Leader>f', ':FzfLua files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rg', ':FzfLua live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>rrg', ':FzfLua live_grep_resume<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>o', ':only<CR>', { silent = true })
vim.keymap.set('n', '<Leader>c', ':cclose<CR>', { silent = true })
vim.keymap.set('v', '<Leader>y', '"+y', { silent = true })

-- vim-test configuration: Sets the strategy for running tests (No default)
vim.keymap.set('n', '<Leader>t', ':TestNearest<CR>', { silent = true, desc = "Run current test" })
vim.keymap.set('n', '<Leader>T', ':TestSuite<CR>', { silent = true, desc = "Run test suite" })

-- Fugitive mappings: Shortcuts for Git operations (No defaults)
vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>', { silent = true })
vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit<CR>', { silent = true })

vim.keymap.set('n', '<Leader>b', ':call ToggleNumbers()<CR>', { silent = true, desc = "Toggle Numbers" })

-- jump directly to a specific pane
for i = 1, 9 do
  vim.keymap.set('n', '<Leader>' .. i, i .. '<C-w>w', { desc = "Move to window " .. i })
end

require('keymaps.lsp')
require('keymaps.codecompanion')
