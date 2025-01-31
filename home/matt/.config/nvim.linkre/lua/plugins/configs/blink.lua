local blink = require("blink.cmp")
blink.setup({
	fuzzy = {
		prebuilt_binaries = {
			force_version = "v0.11.0", -- Replace with the latest version
		},
	},
	snippets = {
		expand = function(snippet)
			return require("luasnip").lsp_expand(snippet)
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
			-- 	border = "single",
			auto_show = false,
			-- draw = {
			-- 	gap = 2,
			-- 	treesitter = { "lsp" },
			-- },
			-- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None",
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			-- window = {
			-- 	border = "double",
			-- 	winhighlight = "Normal:Normal,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
			-- },
		},
		ghost_text = {
			-- enabled = vim.g.ai_cmp,
			enabled = true,
		},
		trigger = {
			-- by default, blink.cmp will block newline, tab and space trigger characters, disable that behavior
			show_on_blocked_trigger_characters = {},
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
				name = "RenderMarkdown",
				module = "render-markdown.integ.blink",
				fallbacks = { "lsp" },
			},

			lsp = {
				override = {
					-- add newline, tab and space to LSP source trigger characters
					get_trigger_characters = function(self)
						local trigger_characters = self:get_trigger_characters()
						vim.list_extend(trigger_characters, { "\n", "\t", " " })
						return trigger_characters
					end,
				},
			},
		},
		cmdline = {},
	},

	keymap = {
		preset = "super-tab",
	},
})
