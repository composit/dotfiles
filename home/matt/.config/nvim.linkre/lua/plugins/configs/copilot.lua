print('setting up copilot')
require("copilot").setup({
		suggestion = {
				enabled = false,
				-- auto_trigger = true,
				-- keymap = {
				-- 		accept = "<Tab>",
				-- 		accept_word = false,
				-- 		accept_line = false,
				-- 		next = "<C-l>",
				-- 		prev = "<C-h>",
				-- 		dismiss = "<C-]>",
				-- },
		},
		panel = {
				enabled = false,
		},
})
