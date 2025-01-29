-- enable true color support
vim.opt.termguicolors = true

-- Searches are case-insensitive by default
-- If the search pattern contains any uppercase letters, it becomes case-sensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- conditionally indent
vim.opt.smartindent = true

-- Sets the minimum number of screen lines to keep above and below the cursor (Default: 0)
vim.opt.scrolloff = 10

-- Defines how invisible characters are displayed (Default: "eol:$")
vim.opt.listchars = { tab = '| ', trail = '·' }

-- Determines the kind of folding used for the current window (Default: "manual")
vim.opt.foldmethod = 'syntax'

-- Controls whether folds are open or closed when first entering a buffer (Default: true)
vim.opt.foldenable = false

-- Sets the color scheme for syntax highlighting (Default: depends on terminal)
-- vim.cmd.colorscheme('melange')
vim.cmd.colorscheme('mr_colorscheme')

-- Customizes highlight groups for various UI elements (Defaults vary)
-- creates a transparent background
vim.api.nvim_set_hl(0, 'Visual', { bg = 'grey' })
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'EmptyLines', { bg = 'none' })
vim.api.nvim_set_hl(0, 'SpecialKey', { bg = 'none' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NonText', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Comment', { bg = 'none' })

-- Sets the leader key for custom mappings (Default: "\")
vim.g.mapleader = ' '

-- Gist configuration: Controls behavior of gist plugin (No defaults)
-- vim.g.gist_detect_filetype = 1
-- vim.g.gist_open_browser_after_post = 1
-- vim.g.gist_post_private = 1

-- Copilot configuration: Sets up GitHub Copilot AI assistant (No defaults)
-- vim.g.copilot_no_tab_map = true

-- Toggle numbers function: Toggles line numbers and listchars (No default)
vim.o.signcolumn = "no" -- default to no
function ToggleNumbers()
    if vim.b.toggle_numbers_on == nil or vim.b.toggle_numbers_on == false then
        vim.b.toggle_numbers_on = true
    else
        vim.b.toggle_numbers_on = false
    end

    vim.wo.number = vim.b.toggle_numbers_on
    vim.o.list = vim.b.toggle_numbers_on
    -- vim.o.signcolumn = vim.b.toggle_numbers_on and "yes" or "no"
end

-- show the window numbers in the status bar
-- %f: Path to the file in the buffer
-- %m: Modified flag
-- %r: Read-only flag
-- %h: Help buffer flag
-- %w: Preview window flag
-- %=: Right-align the following items
-- %{winnr()} neovim window number
-- %l: Current line number
-- %c: Current column number
-- %p%%: Percentage through file
vim.opt.statusline = "%f %m%r%h%w%=%{winnr()} %l,%c %p%%"
