-- Setup language server.
local lspconfig = require('lspconfig')

-- gopls
lspconfig.gopls.setup {
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
	unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
