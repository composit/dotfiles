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
  let in_test = match(current_file, '^test/.*_test\.exs$') != -1
  if in_test
    let new_file = substitute(new_file, '_test\.exs$', '\.ex', '')
    let new_file = substitute(new_file, '^test/', 'lib/', '')
  else
    let new_file = substitute(new_file, '\.ex$', '_test\.exs', '')
    let new_file = substitute(new_file, '^lib/', 'test/', '')
  endif
  return new_file
endfunction
noremap <leader>. :call OpenTestAlternate()<cr>
