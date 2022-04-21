if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

call Enable_coding_plugins()

packadd typescript-vim

setlocal tabstop=2
setlocal softtabstop=0
setlocal expandtab
setlocal shiftwidth=2
setlocal smarttab

let b:ale_linters = ['tslint', 'tsserver', 'typecheck']
let b:ale_fixers = ['tslint']

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
  let in_test = match(current_file, '\.spec\.ts$') != -1
  if in_test
    let new_file = substitute(new_file, '\.spec\.ts$', '\.ts', '')
  else
    let new_file = substitute(new_file, '\.ts$', '\.spec\.ts', '')
  endif
  return new_file
endfunction
noremap <leader>. :call OpenTestAlternate()<cr>
