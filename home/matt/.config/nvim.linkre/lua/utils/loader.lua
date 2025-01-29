local function install_plugins(plugins)
	local install_path = vim.fn.stdpath('data') .. '/site/pack/3rd-party-plugins/'

	vim.fn.mkdir(install_path, "p")

	local fs = vim.loop

	for dir, pluginSet in pairs(plugins) do
		local dir_path = install_path .. dir .. '/'

		vim.fn.mkdir(dir_path, "p")
		for _, plugin in ipairs(pluginSet) do
			local plugin_name = plugin:match("([^/]+)%.git$")
			local plugin_path = dir_path .. plugin_name

			if not fs.fs_stat(plugin_path) then
				print("Installing " .. plugin_name)
				local success = vim.fn.system({ 'git', 'clone', '--depth', '1', plugin, plugin_path })
				print(plugin_name ..
					" installed successfully (" .. plugin .. ": " .. plugin_path .. ") " .. success)
			end
		end
	end
end

-- List of plugin repositories
local plugins = {}
plugins['start'] = {
	'https://github.com/savq/melange-nvim.git',
	'https://github.com/ibhagwan/fzf-lua.git',
	'https://github.com/nvim-lua/plenary.nvim.git',               -- required by a bunch (codecompanion, etc)
	'https://github.com/nvim-treesitter/nvim-treesitter.git',
	'https://github.com/zbirenbaum/copilot.lua.git',              -- required by codecompanion
	'https://github.com/MeanderingProgrammer/render-markdown.nvim.git', -- used by codecompanion
	'https://github.com/olimorris/codecompanion.nvim.git',
	'https://github.com/Saghen/blink.cmp.git',
	'https://github.com/Saghen/blink.compat.git',        -- required by blink, makes it nvm-cmp compatible
	'https://github.com/giuxtaposition/blink-cmp-copilot.git', -- required to integrate blink and copilot
	'https://github.com/L3MON4D3/LuaSnip.git',           -- required by blink
	'https://github.com/rafamadriz/friendly-snippets.git', -- required by blink
	'https://github.com/folke/which-key.nvim.git',
	'https://github.com/neovim/nvim-lspconfig.git',
}
plugins['opt'] = {
	'https://github.com/slashmili/alchemist.vim.git', -- elixir
	'https://github.com/pearofducks/ansible-vim.git',
	'https://github.com/psf/black.git',
	'https://github.com/kien/rainbow_parentheses.vim.git',
	'https://github.com/leafgarland/typescript-vim.git',
	'https://github.com/guns/vim-clojure-highlight.git',
	'https://github.com/guns/vim-clojure-static.git',
	'https://github.com/elixir-editors/vim-elixir.git',
	'https://github.com/tpope/vim-endwise.git',
	'https://github.com/tpope/vim-fireplace.git',
	'https://github.com/tpope/vim-fugitive.git',
	'https://github.com/tpope/vim-rails.git',
	'https://github.com/stevearc/conform.nvim.git',
	--'https://github.com/mattn/vim-gist.git',
	--'https://github.com/mattn/webapi-vim.git', -- required by vim-gist
	--'https://github.com/sebdah/vim-delve.git',
}

install_plugins(plugins)
