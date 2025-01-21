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
vim.cmd('packadd plenary.nvim')
vim.cmd('packadd nui.nvim')
vim.cmd('packadd copilot.lua')
vim.cmd('packadd avante.nvim')
require('avante_lib').load()
require('avante').setup ({
  provider = "copilot",
  file_selector = {
    --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "telescope" | string
    provider = "fzf",
    -- Options override for custom providers
    provider_opts = {},
  },
  compat = {
    "avante_commands",
    "avante_mentions",
    "avante_files",
  }
})
