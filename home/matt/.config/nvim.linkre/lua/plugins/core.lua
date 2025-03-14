-- plugins in the `start` dir
require("plugins.configs.fzf-lua")
require("plugins.configs.nvim-treesitter")
require("plugins.configs.copilot")
require("plugins.configs.render-markdown")
require("luasnip.loaders.from_vscode").lazy_load()
require("plugins.configs.blink")
require("plugins.configs.which-key")
require("plugins.configs.codecompanion")
require("plugins.configs.conform")

-- need to load all lsp configs here instead of in individual ftplugin files because of load order issues (needed to call setup() twice)
require("plugins.configs.nvim-lspconfig")
require("lsp.servers.gopls")
require("lsp.servers.efm-langserver") -- for golangci-lint (others?)
require("lsp.servers.ruby-lsp")       -- has to be called after 'blink' is loaded
require("lsp.servers.lua-ls")
require("lsp.servers.nixd")
