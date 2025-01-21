require("CopilotChat").setup {
  debug = true, -- Enable debugging
}

vim.keymap.set('n', '<leader>cc', ':CopilotChat<cr>', opts)
vim.keymap.set('v', '<leader>ce', ':CopilotChatExplain<cr>', opts)
vim.keymap.set('v', '<leader>cf', ':CopilotChatFix<cr>', opts)
vim.keymap.set('v', '<leader>ct', ':CopilotChatTests<cr>', opts)
