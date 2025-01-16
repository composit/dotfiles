local tmux_session = 'notes'
local tmux_window = 'tests'

function run_all_tests()
  tmux_send("go test ./...")
end

local FUNC_PATTERN = [[\C^\s*func\s+Test(\w+)\s*(]]
local SCENARIO_PATTERN = [[\v^\s*t\.Run\("([^"]+)",\s*func\(\s*t\s*\*\s*testing\.T\s*\)\s*\{]]
local METHOD_PATTERN = [[\C^\s*func\s+(\w\s+\*\w+)\s+Test(\w+)\s*(]]

function run_test_func()
  local in_test_func = vim.fn.expand("%"):match('.*_test%.go$') ~= nil

  if in_test_func then
    set_test_func()
  elseif not vim.t.grb_test_func then
    return
  end

  run_tests(vim.t.grb_test_dir, vim.t.grb_test_func)
end

function func_name()
  local lnum = vim.fn.line('.')
  local method = ''
  local scenario = ''

  while lnum > 0 do
    local line = vim.fn.getline(lnum)

    if method == '' then
      local m = vim.fn.matchlist(line, METHOD_PATTERN)
      if #m > 0 then
        method = '$/'..(m[2] or '')
      end
    end

    if scenario == '' then
      local m = vim.fn.matchlist(line, SCENARIO_PATTERN)
      if #m > 0 then
        scenario = '$/'..(m[2] or '')
      end
    end

    local m = vim.fn.matchlist(line, FUNC_PATTERN)
    if #m > 0 then
      return (m[2] or '')..(method or '')..(scenario or '')
    end

    lnum = lnum - 1
  end

  return ''
end

function set_test_func()
  vim.t.grb_test_dir = "./" .. vim.fn.expand("%:h")
  vim.t.grb_test_func = func_name()
end

function run_tests(dir, func)
  vim.cmd('w')
  tmux_send("go test -v -run '" .. func .. "$' " .. dir)
end

function tmux_send(cmd)
  vim.fn.system("tmux send-keys -t '" .. tmux_session .. ":" .. tmux_window .. "' \"" .. cmd .. "\" C-m")
end

function debug_clear_all()
  tmux_send("clearall")
end

function debug_set_breakpoint()
  tmux_send("break " .. vim.fn.expand("%") .. ":" .. vim.fn.line("."))
  debug_continue()
end

function debug_continue()
  tmux_send("continue")
end

function debug_exit()
  tmux_send("exit")
end

function debug_test_func()
  local in_test_func = vim.fn.expand("%"):match('.*_test%.go$') ~= nil

  if in_test_func then
    set_test_func()
  elseif not vim.t.grb_test_func then
    return
  end

  debug_tests(vim.t.grb_test_dir, vim.t.grb_test_func)
end

function debug_tests(dir, func)
  vim.cmd('w')
  tmux_send("dlv test " .. dir .. " -- -test.v -test.run '" .. func .. "$'")
end

function debug_run()
  vim.cmd('w')
  tmux_send("dlv debug -- \\$RUN_FLAGS")
end

function debug_test_breakpoint()
  debug_test_func()
  debug_set_breakpoint()
end

function debug_run_breakpoint()
  debug_run()
  debug_set_breakpoint()
end

-- OPEN TEST OR PRODUCTION CODE IN SPLIT
function open_test_alternate()
  local new_file = alternate_for_current_file()
  vim.cmd(':vsp ' .. new_file)
end

function alternate_for_current_file()
  local current_file = vim.fn.expand("%")
  local new_file = current_file
  local in_test = current_file:match('_test%.go$') ~= nil

  if in_test then
    new_file = new_file:gsub('_test%.go$', '%.go')
  else
    new_file = new_file:gsub('%.go$', '_test%.go')
  end

  return new_file
end
