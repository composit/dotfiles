local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

lspconfig.ruby_lsp.setup({
	formatter = "standard",
	linters = { "standard" },
	settings = {
		fileTypes = { "ruby", "eruby" },
		rubocop = {
			lint = true,
			autocorrect = true,
		},
	},
	capabilities = capabilities,
})
