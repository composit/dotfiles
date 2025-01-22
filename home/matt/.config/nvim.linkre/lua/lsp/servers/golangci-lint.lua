-- Setup language server.
local lspconfig = require('lspconfig')
local capabilities = require('blink.cmp').get_lsp_capabilities()


-- golangci-lint
lspconfig.golangci_lint_ls.setup({
	init_options = {
		command = { "golangci-lint", "run", "--config", "~/golangci.yml", "--build-tags", "integration", "--out-format", "json", "--issues-exit-code=1" }
	},
	capabilities = capabilities,
})
