vim.cmd('packadd vim-fugitive')

vim.cmd('packadd mini.pairs')
require('plugins.configs.minipairs')

vim.cmd('packadd nvim-treesitter')
require('plugins/configs/nvim-treesitter')

require('plugins.avante')
require('options.avante')
