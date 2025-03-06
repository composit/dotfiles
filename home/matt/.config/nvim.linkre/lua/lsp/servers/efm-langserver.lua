local capabilities = require("blink.cmp").get_lsp_capabilities()

require("lspconfig")["efm"].setup({
	filetypes = { "go" },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			go = {
				{
					lintCommand = "golangci-lint run --config ~/golangci.yml --build-tags integration --out-format line-number",
					lintFormats = { "%f:%l:%c: %m" },
					lintSource = "golangci-lint",
					lintStdin = true,
				},
			},
		},
	},
	capabilities = capabilities,
})
