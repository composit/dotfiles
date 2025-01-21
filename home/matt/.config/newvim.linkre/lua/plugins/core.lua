vim.cmd('packadd fzf-lua')
require('plugins.configs.fzf-lua')

--vim.cmd('packadd friendly-snippets') -- required by blink.cmp
vim.cmd('packadd blink.cmp')
require('plugins.configs.blink')

-- need to load all lsp configs here instead of in individual ftplugin files because of load order issues (needed to call setup() twice)
vim.cmd('packadd nvim-lspconfig')
require('plugins.configs.nvim-lspconfig')
require('lsp.servers.gopls')
require('lsp.servers.golangci-lint')
require('lsp.servers.ruby-lsp') -- has to be called after 'blink' is loaded
