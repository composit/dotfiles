local function install_plugins(plugins)
	print("Ensuring plugins are installed")
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
				local success = vim.fn.system({'git', 'clone', '--depth', '1', plugin, plugin_path})
				print(plugin_name .. " installed successfully (" .. plugin .. ": " .. plugin_path .. ") " .. success)
			else
				print(plugin_name .. " already installed")
			end
		end
	end
end

-- List of plugin repositories
local plugins = {}
plugins['start'] = {
	'https://github.com/sjl/badwolf.git',
	'https://github.com/junegunn/fzf.vim.git',
	'https://github.com/junegunn/fzf.git',
}
plugins['opt'] = {
	'https://github.com/slashmili/alchemist.vim.git',
	'https://github.com/dense-analysis/ale.git',
	'https://github.com/pearofducks/ansible-vim.git',
	'https://github.com/psf/black.git',
	'https://github.com/neovim/nvim-lspconfig.git',
	'https://github.com/nvim-lua/plenary.nvim.git',
	'https://github.com/kien/rainbow_parentheses.vim.git',
	'https://github.com/leafgarland/typescript-vim.git',
	'https://github.com/guns/vim-clojure-highlight.git',
	'https://github.com/guns/vim-clojure-static.git',
	'https://github.com/elixir-editors/vim-elixir.git',
	'https://github.com/tpope/vim-endwise.git',
	'https://github.com/tpope/vim-fireplace.git',
	'https://github.com/tpope/vim-fugitive.git',
	--'https://github.com/mattn/vim-gist.git',
	'https://github.com/tpope/vim-rails.git',
	--'https://github.com/janko-m/vim-test.git',
	--'https://github.com/mattn/webapi-vim.git',
	--'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
	--'https://github.com/zbirenbaum/copilot.lua',
	--'https://github.com/github/copilot.vim.git',
	--'https://github.com/jgdavey/tslime.vim.git',
	--'https://github.com/flazz/vim-colorschemes.git',
	--'https://github.com/sebdah/vim-delve.git',
}

install_plugins(plugins)
