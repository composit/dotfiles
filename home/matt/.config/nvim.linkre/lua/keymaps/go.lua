-- RUNNING TESTS
vim.keymap.set('n', '<leader>t', function() Run_test_func() end)
vim.keymap.set('n', '<leader>T', function() Run_all_tests() end)
vim.keymap.set('n', '<leader>.', function() Open_test_alternate() end)

-- DEBUGGING
vim.keymap.set('n', '<leader>vt', function() Debug_test_func() end)
vim.keymap.set('n', '<leader>vc', function() Debug_continue() end)
vim.keymap.set('n', '<leader>vx', function() Debug_exit() end)
vim.keymap.set('n', '<leader>vb', function() Debug_set_breakpoint() end)
vim.keymap.set('n', '<leader>va', function() Debug_clear_all() end)
vim.keymap.set('n', '<leader>vv', function() Debug_test_breakpoint() end)
vim.keymap.set('n', '<leader>vr', function() Debug_run_breakpoint() end)
