-- Open javascript files
vim.keymap.set('n', '<leader>j', ':CommandTFlush<CR>|:CommandT app/assets/javascripts<CR>')

-- RUNNING TESTS
vim.keymap.set('n', '<leader>t', function() run_test_file() end)
vim.keymap.set('n', '<leader>a', function() run_tests('') end)
vim.keymap.set('n', '<leader>.', function() open_test_alternative() end)
