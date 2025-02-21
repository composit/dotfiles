local tmux_session = "notes"
local tmux_window = "tests"

local function tmux_send(cmd)
	vim.fn.system("tmux send-keys -t '" .. tmux_session .. ":" .. tmux_window .. "' \"" .. cmd .. '" C-m')
end

function Run_all_tests()
	tmux_send("go test ./...")
end

-- "^%s*func%s+Test(%w+)%s*%(%s*[%w_]*%s*%*testing%.T%s*%)",  -- matches standard signature
-- "^%s*func%s+Test(%u%w+)%s*%(.*%*testing%.T.*%)"            -- more flexible signature match

local func_pattern = "^%s*func%s+Test([%w_]+)%s*%(.*%*testing%.T.*%)"
local scenario_pattern = '^%s*t%.Run%("([^"]+)",%s*func%(%s*t%s*%*%s*testing%.T%s*%)%s*%{'
local method_pattern = "^%s*func%s+%([%w_]+%s+%*?[%w_]+%)%s+Test([%w_]+)%s*%("

local function func_name()
	local lnum = vim.fn.line(".")
	local method = ""
	local scenario = ""

	while lnum > 0 do
		local line = vim.fn.getline(lnum)

		if method == "" then
			local m = string.match(line, method_pattern)
			if m then
				method = "$/" .. (m or "")
			end
		end

		if scenario == "" then
			local m = string.match(line, scenario_pattern)
			if m then
				scenario = "$/" .. (m or "")
			end
		end

		local m = string.match(line, func_pattern)
		if m then
			return (m or "") .. (method or "") .. (scenario or "")
		end

		lnum = lnum - 1
	end

	return ""
end

local function set_test_func()
	vim.t.grb_test_dir = "./" .. vim.fn.expand("%:h")
	vim.t.grb_test_func = func_name()
end

local function run_tests(dir, func)
	vim.cmd("w")
	tmux_send("go test -v -run '" .. func .. "$' " .. dir)
end

function Run_test_func()
	local in_test_func = vim.fn.expand("%"):match(".*_test%.go$") ~= nil

	if in_test_func then
		set_test_func()
	elseif not vim.t.grb_test_func then
		return
	end

	run_tests(vim.t.grb_test_dir, vim.t.grb_test_func)
end

function Debug_clear_all()
	tmux_send("clearall")
end

function Debug_set_breakpoint()
	tmux_send("break " .. vim.fn.expand("%") .. ":" .. vim.fn.line("."))
	Debug_continue()
end

function Debug_continue()
	tmux_send("continue")
end

function Debug_exit()
	tmux_send("exit")
end

local function debug_tests(dir, func)
	vim.cmd("w")
	tmux_send("dlv test " .. dir .. " -- -test.v -test.run '" .. func .. "$'")
end

function Debug_test_func()
	local in_test_func = vim.fn.expand("%"):match(".*_test%.go$") ~= nil

	if in_test_func then
		set_test_func()
	elseif not vim.t.grb_test_func then
		return
	end

	debug_tests(vim.t.grb_test_dir, vim.t.grb_test_func)
end

local function debug_run()
	vim.cmd("w")
	tmux_send("dlv debug -- \\$RUN_FLAGS")
end

function Debug_test_breakpoint()
	Debug_test_func()
	Debug_set_breakpoint()
end

function Debug_run_breakpoint()
	debug_run()
	Debug_set_breakpoint()
end

-- OPEN TEST OR PRODUCTION CODE IN SPLIT
local function alternate_for_current_file()
	local current_file = vim.fn.expand("%")
	local new_file = current_file
	local in_test = current_file:match("_test%.go$") ~= nil

	if in_test then
		new_file = new_file:gsub("_test%.go$", "%.go")
	else
		new_file = new_file:gsub("%.go$", "_test%.go")
	end

	return new_file
end

function Open_test_alternate()
	local new_file = alternate_for_current_file()
	vim.cmd(":vsp " .. new_file)
end
