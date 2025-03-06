-- Function to open filtered files using fzf-lua
-- Excludes files that start with a specified string pattern
vim.api.nvim_create_user_command('FilterFiles', function(opts)
	-- Import fzf-lua
	local fzf = require('fzf-lua')

	-- Get the filter pattern from the command argument
	local filter_pattern = opts.args or ""

	-- Filter out files that start with the specified string
	local cmd = "rg --type ruby --files-without-match '^" .. filter_pattern .. "'"

	-- Get all files
	local filtered_files = vim.fn.systemlist(cmd)

	-- Use fzf-lua to select from the filtered files
	fzf.fzf_exec(filtered_files, {
		prompt = "Files (excluding '" .. filter_pattern .. "'): ",
		actions = {
			-- Default action: open the selected file
			["default"] = function(selected)
				local file = selected[1]
				if file then
					vim.cmd('edit ' .. vim.fn.fnameescape(file))
				end
			end
		}
	})
end, {
	nargs = '?', -- Optional argument
	desc = 'Open files that don\'t start with the given string'
})
