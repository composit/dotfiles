print('setting up copilot')
require("copilot").setup({
		suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				keymap = {
						accept = "<Tab>",
						accept_word = false,
						accept_line = false,
						next = "<C-l>",
						prev = "<C-h>",
						dismiss = "<C-]>",
				},
		},
		panel = {
				enabled = true,
		},
})
