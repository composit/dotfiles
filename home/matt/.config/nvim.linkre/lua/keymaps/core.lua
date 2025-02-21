vim.keymap.set("n", "<Leader>h", ":set invhls<CR>", { silent = true, desc = "Toggle highlights" })
vim.keymap.set("x", ".", ":norm.<CR>", { silent = true })
vim.keymap.set("n", "<Leader>f", ":FzfLua files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rg", ":FzfLua live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rrg", ":FzfLua live_grep_resume<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>o", ":only<CR>", { silent = true })
vim.keymap.set("n", "<Leader>cx", ":cclose<CR>", { silent = true, desc = "close the quickfix window" })
vim.keymap.set("v", "<Leader>y", '"+y', { silent = true })
vim.keymap.set("n", "<Leader>i", ":Inspect<CR>", { silent = true })

-- vim-test configuration: Sets the strategy for running tests (No default)
vim.keymap.set("n", "<Leader>t", ":TestNearest<CR>", { silent = true, desc = "Run current test" })
vim.keymap.set("n", "<Leader>T", ":TestSuite<CR>", { silent = true, desc = "Run test suite" })

-- Fugitive mappings: Shortcuts for Git operations (No defaults)
vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gd", ":Gvdiffsplit<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gm", ":Gvdiffsplit main<CR>", { silent = true })

vim.keymap.set("n", "<Leader>b", ":lua ToggleNumbers()<CR>", { silent = true, desc = "Toggle Numbers" })

-- jump directly to a specific pane
for i = 1, 9 do
	vim.keymap.set("n", "<Leader>" .. i, i .. "<C-w>w", { desc = "Move to window " .. i })
end

-- update plugins
vim.keymap.set("n", "<Leader>up", ":lua UpdatePlugins()<CR>", { silent = true, desc = "Update plugins" })

require("keymaps.lsp")
require("keymaps.codecompanion")
