if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal tabstop=2
setlocal softtabstop=0
setlocal expandtab
setlocal shiftwidth=2
setlocal smarttab

let b:ale_fixers = ['tslint']
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" go to definition in new tab
nmap <Leader>dt :ALEGoToDefinitionInTab<CR>

" Tests
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
