-- Open javascript files
vim.keymap.set('n', '<leader>j', ':CommandTFlush<CR>|:CommandT app/assets/javascripts<CR>')

-- RUNNING TESTS
vim.keymap.set('n', '<leader>t', function() RunTestFile() end)
vim.keymap.set('n', '<leader>a', function() RunTests('') end)
vim.keymap.set('n', '<leader>.', function() OpenTestAlternative() end)
