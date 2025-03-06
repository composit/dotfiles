local lspconfig = require("lspconfig")
local capabilities = require('blink.cmp').get_lsp_capabilities()

lspconfig.lua_ls.setup({
	settings = {
		fileTypes = {"lua"},
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
	capabilities = capabilities,
})
