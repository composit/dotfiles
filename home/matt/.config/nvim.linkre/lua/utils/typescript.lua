if vim.fn.exists('*open_test_alternate') == 1 then
  return
end

local function open_test_alternate()
  local new_file = alternate_for_current_file()
  vim.cmd('vsp ' .. new_file)
end

local function alternate_for_current_file()
  local current_file = vim.fn.expand("%")
  local new_file = current_file
  local in_test = current_file:match('%.spec%.ts$') ~= nil

  if in_test then
    new_file = new_file:gsub('%.spec%.ts$', '.ts')
  else
    new_file = new_file:gsub('%.ts$', '.spec.ts')
  end

  return new_file
end
