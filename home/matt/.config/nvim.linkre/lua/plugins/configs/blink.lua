require('blink.cmp').setup({
	fuzzy = {
		prebuilt_binaries = {
			force_version = "v0.10.0" -- Replace with the latest version
		}
	},
	--version = "*",
	snippets = {
		expand = function(snippet, _)
			return require('luasnip').lsp_expand(snippet)
		end,
	},
	appearance = {
		-- sets the fallback highlight groups to nvim-cmp's highlight groups
		-- useful for when your theme doesn't support blink.cmp
		-- will be removed in a future release, assuming themes add support
		use_nvim_cmp_as_default = true,
		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},
	completion = {
		accept = {
			-- experimental auto-brackets support
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			border = "single",
			draw = {
				gap = 2,
				treesitter = { "lsp" },
			},
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None",
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = {
				border = "double",
				winhighlight = "Normal:Normal,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
			},
		},
		ghost_text = {
			enabled = vim.g.ai_cmp,
		},
	},

	-- experimental signature help support
	-- signature = { enabled = true },

	sources = {
		default = { "copilot", "lsp", "path", "snippets", "buffer" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-cmp-copilot",
				-- kind = "Copilot",
				score_offset = 100,
				async = true,
			},
			markdown = {
				name = 'RenderMarkdown',
				module = 'render-markdown.integ.blink',
				fallbacks = { 'lsp' },
			},
		},
		cmdline = {},
	},

	keymap = {
		preset = "super-tab",
	},
})
