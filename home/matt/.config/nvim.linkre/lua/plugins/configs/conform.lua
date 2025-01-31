require("conform").setup({
	formatters_by_ft = {
		go = { "gofumpt", "goimports" },
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { "prettierd", "prettier" },
	},
	format_on_save = {
		lsp_format = "fallback",
	},
})
