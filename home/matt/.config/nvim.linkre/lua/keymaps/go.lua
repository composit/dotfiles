-- RUNNING TESTS
vim.keymap.set('n', '<leader>t', function() Run_test_func() end, { desc = "Run current test" })
vim.keymap.set('n', '<leader>T', function() Run_all_tests() end, { desc = "Run test suite" })
vim.keymap.set('n', '<leader>.', function() Open_test_alternate() end, { desc = "Open test alternate" })

-- DEBUGGING
vim.keymap.set('n', '<leader>vv', function() Debug_test_breakpoint() end,
	{ desc = "Debug the current test with a breakpoint" })
vim.keymap.set('n', '<leader>vr', function() Debug_run_breakpoint() end,
	{ desc = "Debug the main code with a breakpoint" })
vim.keymap.set('n', '<leader>vt', function() Debug_test_func() end, { desc = "Debug the current test" })
vim.keymap.set('n', '<leader>vc', function() Debug_continue() end, { desc = "Continue" })
vim.keymap.set('n', '<leader>vx', function() Debug_exit() end, { desc = "Exit" })
vim.keymap.set('n', '<leader>vb', function() Debug_set_breakpoint() end, { desc = "Set breakpoint" })
vim.keymap.set('n', '<leader>va', function() Debug_clear_all() end, { desc = "Clear all" })
