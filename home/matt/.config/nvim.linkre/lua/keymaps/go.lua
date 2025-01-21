-- RUNNING TESTS
vim.keymap.set('n', '<leader>t', function() run_test_func() end)
vim.keymap.set('n', '<leader>T', function() run_all_tests() end)
vim.keymap.set('n', '<leader>.', function() open_test_alternate() end)

-- DEBUGGING
vim.keymap.set('n', '<leader>vt', function() debug_test_func() end)
vim.keymap.set('n', '<leader>vc', function() debug_continue() end)
vim.keymap.set('n', '<leader>vx', function() debug_exit() end)
vim.keymap.set('n', '<leader>vb', function() debug_set_breakpoint() end)
vim.keymap.set('n', '<leader>va', function() debug_clear_all() end)
vim.keymap.set('n', '<leader>vv', function() debug_test_breakpoint() end)
vim.keymap.set('n', '<leader>vr', function() debug_run_breakpoint() end)
