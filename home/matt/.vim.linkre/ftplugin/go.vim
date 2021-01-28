setlocal tabstop=8
setlocal nosmarttab
setlocal shiftwidth=8
setlocal noexpandtab

" default to verbose for go tests
nmap <Leader>t :TestNearest -v <CR>

let b:ale_linters = ['gofmt', 'golint', 'govet', 'gopls', 'golangci-lint']
let b:ale_fixers = ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace']

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
  let in_test = match(current_file, '_test\.go$') != -1
  if in_test
    let new_file = substitute(new_file, '_test\.go$', '\.go', '')
  else
    let new_file = substitute(new_file, '\.go$', '_test\.go', '')
  endif
  return new_file
endfunction
noremap <leader>. :call OpenTestAlternate()<cr>
