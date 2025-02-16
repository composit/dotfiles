local function install_plugins(plugins)
	local install_path = vim.fn.stdpath("data") .. "/site/pack/3rd-party-plugins/"

	vim.fn.mkdir(install_path, "p")

	local fs = vim.loop

	for dir, pluginSet in pairs(plugins) do
		local dir_path = install_path .. dir .. "/"

		vim.fn.mkdir(dir_path, "p")
		for plugin_name, plugin in pairs(pluginSet) do
			local plugin_path = dir_path .. plugin_name

			if not fs.fs_stat(plugin_path) then
				print("Installing " .. plugin_name)
				local success = vim.fn.system({ "git", "clone", "--depth", "1", plugin, plugin_path })
				print(plugin_name ..
					" installed successfully (" .. plugin .. ": " .. plugin_path .. ") " .. success)
			end
		end
	end
end

-- List of plugin repositories
local plugins = {}
plugins["start"] = {
	["hsluv/lua"] = "https://github.com/hsluv/hsluv-lua.git",
	mr_colorscheme = "https://git.sr.ht/~mr_mattr/mr_colorscheme",
	fzf_lua = "https://github.com/ibhagwan/fzf-lua.git",
	plenary = "https://github.com/nvim-lua/plenary.nvim.git", -- required by a bunch (codecompanion, etc)
	nvim_treesitter = "https://github.com/nvim-treesitter/nvim-treesitter.git",
	copilot = "https://github.com/zbirenbaum/copilot.lua.git",
	render_markdown = "https://github.com/MeanderingProgrammer/render-markdown.nvim.git", -- used by codecompanion
	codecompanion = "https://github.com/olimorris/codecompanion.nvim.git",
	blink_cmp = "https://github.com/Saghen/blink.cmp.git",
	blink_compat = "https://github.com/Saghen/blink.compat.git",            -- required by blink, makes it nvm-cmp compatible
	blink_cmp_copilot = "https://github.com/giuxtaposition/blink-cmp-copilot.git", -- required to integrate blink and copilot
	LuaSnip = "https://github.com/L3MON4D3/LuaSnip.git",                    -- required by blink
	friendly_snippets = "https://github.com/rafamadriz/friendly-snippets.git", -- required by blink
	which_key = "https://github.com/folke/which-key.nvim.git",
	nvim_lspconfig = "https://github.com/neovim/nvim-lspconfig.git",
}
plugins["opt"] = {
	alchemist = "https://github.com/slashmili/alchemist.vim.git", -- elixir
	ansible_vim = "https://github.com/pearofducks/ansible-vim.git",
	black = "https://github.com/psf/black.git",
	rainbow_parentheses = "https://github.com/kien/rainbow_parentheses.vim.git",
	typescript_vim = "https://github.com/leafgarland/typescript-vim.git",
	vim_clojure_highlight = "https://github.com/guns/vim-clojure-highlight.git",
	vim_clojure_static = "https://github.com/guns/vim-clojure-static.git",
	vim_elixir = "https://github.com/elixir-editors/vim-elixir.git",
	vim_endwise = "https://github.com/tpope/vim-endwise.git",
	vim_fireplace = "https://github.com/tpope/vim-fireplace.git",
	vim_fugitive = "https://github.com/tpope/vim-fugitive.git",
	vim_rails = "https://github.com/tpope/vim-rails.git",
	conform = "https://github.com/stevearc/conform.nvim.git",
	vim_nix = "https://github.com/LnL7/vim-nix.git",
	-- vim_gist = 'https://github.com/mattn/vim-gist.git',
	-- webapi_vim = 'https://github.com/mattn/webapi-vim.git', -- required by vim-gist
	-- vim_delve = 'https://github.com/sebdah/vim-delve.git',
}

install_plugins(plugins)

function UpdatePlugins()
	print("updating plugins")
	local install_path = vim.fn.stdpath("data") .. "/site/pack/3rd-party-plugins/"

	for dir, pluginSet in pairs(plugins) do
		local dir_path = install_path .. dir .. "/"

		vim.fn.mkdir(dir_path, "p")
		for plugin_name, plugin in pairs(pluginSet) do
			local plugin_path = dir_path .. plugin_name

			print("Updating " .. plugin_name)
			local success = vim.fn.system({ "git", "-C", plugin_path, "pull" })
			print(plugin_name ..
				" updated successfully (" .. plugin .. ": " .. plugin_path .. ") " .. success)
		end
	end
end
