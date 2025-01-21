-- Call the Enable_coding_plugins function
enable_coding_plugins()

-- Check if the buffer-local variable exists
if vim.b.did_ftplugin then
  return
end

-- Set the buffer-local variable
vim.b.did_ftplugin = 1

-- Set local options
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 0
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.smarttab = true
