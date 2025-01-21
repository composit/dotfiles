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
vim.cmd('colorscheme goodwolf')

-- Customizes highlight groups for various UI elements (Defaults vary)
vim.cmd([[
highlight Visual cterm=none ctermbg=Grey ctermfg=White guibg=Grey guifg=White
highlight LineNr ctermfg=yellow guifg=yellow
highlight Normal ctermbg=NONE ctermfg=NONE guifg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight EmptyLines ctermbg=NONE guibg=NONE
highlight SpecialKey ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight Comment ctermbg=NONE guibg=NONE
]])

-- Sets the leader key for custom mappings (Default: "\")
vim.g.mapleader = ' '

-- Gist configuration: Controls behavior of gist plugin (No defaults)
-- vim.g.gist_detect_filetype = 1
-- vim.g.gist_open_browser_after_post = 1
-- vim.g.gist_post_private = 1

-- Copilot configuration: Sets up GitHub Copilot AI assistant (No defaults)
-- vim.g.copilot_no_tab_map = true

-- Toggle numbers function: Toggles line numbers and listchars (No default)
vim.cmd([[
function! ToggleNumbers()
    set number!
    set list!
endfunction
]])

-- Background transparent function: Removes background colors
vim.cmd([[
function! Background_transparent()
    highlight Normal ctermbg=NONE
    highlight LineNr ctermbg=NONE
    highlight EmptyLines ctermbg=NONE
    highlight SpecialKey ctermbg=none
    highlight SignColumn ctermbg=none
    highlight NonText ctermbg=none
    highlight Comment ctermbg=none
endfunction
]])

vim.cmd('call Background_transparent()')

-- show the window numbers in the status bar
vim.opt.statusline = '%{winnr()} %f'
