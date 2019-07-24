setlocal tabstop=8
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal textwidth=100

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
  let in_test = match(current_file, '^test_.*\.py$') != -1
  if in_test
    let new_file = substitute(new_file, '^test_', '', '')
  else
    let new_file = substitute(new_file, '^', 'test_', '')
  endif
  return new_file
endfunction
noremap <leader>. :call OpenTestAlternate()<cr>

autocmd BufWritePost *.py execute ':Black'
