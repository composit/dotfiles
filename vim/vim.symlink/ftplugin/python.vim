setlocal tabstop=4
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal textwidth=80

" go to definition in new tab
nmap <Leader>dt :ALEGoToDefinitionInTab<CR>

" fixers
let b:ale_fixers = ['add_blank_lines_for_python_control_statements', 'autopep8', 'black', 'isort', 'reorder-python-imports', 'yapf', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_fix_on_save=1

" Tests
let test#python#runner = 'pytest'

nmap <Leader>t :TestNearest<CR>
nmap <Leader>T :TestSuite<CR>

if exists('*OpenTestAlternate')
  finish
endif
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':vsp ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let in_lib = match(current_file, 'src\/lib\/.*\.py$') != -1
  let in_lib_test = match(current_file, 'src\/tests\/test_.*\.py$') != -1
  let in_bin = match(current_file, 'bin\/.*$') != -1
  let in_bin_test = match(current_file, 'tests\/test_.*\.py$') != -1
  if in_lib_test
    let new_file = substitute(current_file, '\/tests\/test_', '\/lib\/', '')
  elseif in_bin_test
    let new_file = substitute(current_file, 'tests\/test_', 'bin\/', '')
    let new_file = substitute(new_file, '.py$', '', '')
  elseif in_lib
    let new_file = substitute(current_file, 'lib\/', 'tests\/test_', '')
  elseif in_bin
    let new_file = substitute(current_file, 'bin\/', 'tests\/test_', '')
    let new_file = substitute(new_file, '$', '.py', '')
  end
  return new_file
endfunction
noremap <leader>. :call OpenTestAlternate()<cr>
