-- Setup language server.
local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- gopls
lspconfig.gopls.setup({
	fileTypes = { "go" },
	settings = {
		gopls = {
			gofumpt = true,
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
	capabilities = capabilities,
})
