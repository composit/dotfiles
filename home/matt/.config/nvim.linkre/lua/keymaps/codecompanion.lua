vim.keymap.set({ 'n', 'v' }, '<Leader>ca', ':CodeCompanionActions<CR>', { silent = true, noremap = true })
vim.keymap.set('i', '<C-Space>', 'codecompanion#complete()', { noremap = true, silent = true, expr = true })
vim.keymap.set({ 'n', 'v' }, '<leader>cp', ':CodeCompanion<CR>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>cr',
    ':CodeCompanion refactor this code. If the code is Go, any extracted functions should accept ctx and log or span as their first two arguments if they are available in the calling function.<CR>',
    { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>ce', ':CodeCompanion /explain<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cc', ':CodeCompanionChat<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ct', ':CodeCompanionChat Toggle<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>cf', ':CodeCompanionChat Fix<CR>', { noremap = true, silent = true })
