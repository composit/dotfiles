local fzf_lua = require('fzf-lua')

-- Custom function to find files not containing a specific string
function FindFilesNotContaining(pattern)
	local cmd = string.format("rg --files --type rb --invert-match -e '%s'", pattern)
	fzf_lua.fzf_exec(cmd, {
		prompt = 'Files not containing: ',
		actions = {
			['default'] = fzf_lua.actions.file_edit,
		}
	})
end

-- Example usage: FindFilesNotContaining("TODO")
