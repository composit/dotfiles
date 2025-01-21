vim.cmd('packadd fzf-lua')
require('plugins.configs.fzf-lua')

vim.cmd('packadd plenary.nvim')

vim.cmd('packadd nvim-treesitter')
require('plugins/configs/nvim-treesitter')

vim.cmd('packadd copilot.lua')
require('plugins.configs.copilot')

vim.cmd('packadd codecompanion.nvim')
require('plugins.configs.codecompanion')

vim.cmd('packadd blink.cmp')
vim.cmd('packadd blink.compat')
vim.cmd('packadd blink-cmp-copilot')
vim.cmd('packadd luasnip')
vim.cmd('packadd friendly-snippets')
require('luasnip.loaders.from_vscode').lazy_load()
require('plugins.configs.blink')
vim.cmd('packadd which-key.nvim')
require('plugins.configs.which-key')

-- need to load all lsp configs here instead of in individual ftplugin files because of load order issues (needed to call setup() twice)
vim.cmd('packadd nvim-lspconfig')
require('plugins.configs.nvim-lspconfig')
require('lsp.servers.gopls')
require('lsp.servers.golangci-lint')
require('lsp.servers.ruby-lsp') -- has to be called after 'blink' is loaded
require('lsp.servers.lua-ls')
