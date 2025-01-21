-- Setup language server.
local lspconfig = require('lspconfig')

-- golangci-lint
lspconfig.golangci_lint_ls.setup({})
