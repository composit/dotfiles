if vim.fn.exists('*open_test_alternate') == 1 then
  return
end

function open_test_alternate()
  local new_file = alternate_for_current_file()
  vim.cmd('vsp ' .. new_file)
end

local function alternate_for_current_file()
  local current_file = vim.fn.expand("%")
  local in_lib = current_file:match('src/lib/.*%.py$') ~= nil
  local in_lib_test = current_file:match('src/tests/test_.*%.py$') ~= nil
  local in_bin = current_file:match('bin/.*$') ~= nil
  local in_bin_test = current_file:match('tests/test_.*%.py$') ~= nil
  local new_file

  if in_lib_test then
    new_file = current_file:gsub('/tests/test_', '/lib/')
  elseif in_bin_test then
    new_file = current_file:gsub('tests/test_', 'bin/')
    new_file = new_file:gsub('%.py$', '')
  elseif in_lib then
    new_file = current_file:gsub('lib/', 'tests/test_')
  elseif in_bin then
    new_file = current_file:gsub('bin/', 'tests/test_')
    new_file = new_file .. '.py'
  end

  return new_file
end
