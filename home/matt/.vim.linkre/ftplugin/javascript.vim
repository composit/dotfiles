if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal tabstop=2
setlocal softtabstop=0
setlocal expandtab
setlocal shiftwidth=2
setlocal smarttab

let b:ale_fixers = ['eslint']

if exists('*OpenTestAlternate')
  finish
endif
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':vsp ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_test = match(current_file, '\.spec\.js$') != -1
  if in_test
    let new_file = substitute(new_file, '\.spec\.js$', '\.js', '')
  else
    let new_file = substitute(new_file, '\.js$', '\.spec\.js', '')
  endif
  return new_file
endfunction
noremap <leader>. :call OpenTestAlternate()<cr>
