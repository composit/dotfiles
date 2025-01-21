-- deps:
--require('cmp').setup ({
--  -- use recommended settings from above
--})
--require('img-clip').setup ({
--  -- use recommended settings from above
--})
--require('copilot').setup ({
--  -- use recommended settings from above
--})
--require('render-markdown').setup ({
--  -- use recommended settings from above
--})
vim.cmd('packadd dressing.nvim')
vim.cmd('packadd nui.nvim')
vim.cmd('packadd copilot.lua')
vim.cmd('packadd avante.nvim')
require('plugins.configs.avante')
