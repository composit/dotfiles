require("CopilotChat").setup {
  debug = true, -- Enable debugging
}

vim.keymap.set('n', '<leader>cc', ':CopilotChat<cr>', opts)
