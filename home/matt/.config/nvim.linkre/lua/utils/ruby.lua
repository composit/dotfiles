local tmux_session = "notes"
local tmux_window = "tests"

if vim.fn.exists('*OpenTestAlternative') == 1 then
	return
end

local function tmux_send(cmd)
	vim.fn.system("tmux send-keys -t '" .. tmux_session .. ":" .. tmux_window .. "' \"" .. cmd .. '" C-m')
end

local function set_test_file()
	if vim.fn.expand("%"):match('%.js%.coffee$') then
		vim.t.grb_test_file = vim.fn.expand("%")
	else
		vim.t.grb_test_file = vim.fn.expand("%") .. ":" .. vim.fn.line('.')
	end
end

function RunTestFile(command_suffix)
	command_suffix = command_suffix or ""

	local in_test_file = vim.fn.expand("%"):match('._spec%.js%.coffee$') or
	    vim.fn.expand("%"):match('_spec%.rb$') or
	    vim.fn.expand("%"):match('_test%.rb$')

	if in_test_file then
		set_test_file()
	elseif not vim.t.grb_test_file then
		return
	end
	RunTests(vim.t.grb_test_file .. command_suffix)
end

function RunTests(filename)
	vim.cmd('w')
	if vim.fn.expand("%"):match('%.js%.coffee$') then
		vim.fn.system("jasmine-headless-webkit --color --no-full-run --runner-out runner.html " .. filename)
	else
		tmux_send('bundle exec rake test ' .. filename)
	end
end

local function alternate_for_current_file()
	local current_file = vim.fn.expand("%")
	local new_file = current_file
	local in_spec = current_file:match('^spec/') ~= nil
	local in_test = current_file:match('^test/') ~= nil
	local in_js = current_file:match('javascripts') ~= nil
	local in_ruby = current_file:match('controllers') ~= nil or
	    current_file:match('models') ~= nil or
	    current_file:match('views') ~= nil or
	    current_file:match('helpers') ~= nil or
	    current_file:match('mailers') ~= nil or
	    current_file:match('api') ~= nil

	if in_spec or in_test then
		if in_js then
			new_file = new_file:gsub('_spec%.js%.coffee$', '.js.coffee')
			new_file = 'app/assets/' .. new_file
		elseif in_spec then
			new_file = new_file:gsub('_spec%.rb$', '.rb')
			new_file = new_file:gsub('^spec/', '')
		elseif in_test then
			new_file = new_file:gsub('_test%.rb$', '.rb')
			new_file = new_file:gsub('^test/unit/', 'app/models/')
			new_file = new_file:gsub('^test/functional/', 'app/controllers/')
		end
		if in_ruby then
			new_file = 'app/' .. new_file
		end
	else
		if in_js then
			new_file = new_file:gsub('^app/assets/', '')
			new_file = new_file:gsub('%.js%.coffee$', '_spec.js.coffee')
			new_file = 'spec/' .. new_file
		elseif vim.fn.filereadable("test/test_helper.rb") == 1 then
			new_file = new_file:gsub('^app/models', 'test/unit')
			new_file = new_file:gsub('^app/controllers', 'test/functional')
			new_file = new_file:gsub('%.rb$', '_test.rb')
		elseif in_ruby then
			new_file = new_file:gsub('^app/', '')
			new_file = new_file:gsub('_controller%.rb', '.rb')
			new_file = new_file:gsub('%.rb$', '_spec.rb')
			new_file = new_file:gsub('^controllers', 'requests')
			new_file = 'spec/' .. new_file
		end
	end
	return new_file
end

function OpenTestAlternative()
	local new_file = alternate_for_current_file()
	vim.cmd(':vsp ' .. new_file)
end
