echom "golang"

call Enable_coding_plugins()

packadd vim-delve

setlocal tabstop=8
setlocal nosmarttab
setlocal shiftwidth=8
setlocal noexpandtab
setlocal textwidth=100

" default to verbose for go tests
nmap <Leader>t :TestNearest -v <CR>

" debug (delve) with a different command
function! DebugNearest()
  let g:test#go#runner = 'delve'
  TestNearest
  unlet g:test#go#runner
endfunction
nmap <Leader>dd :call DebugNearest()<CR>

nmap <Leader>db :DlvAddBreakpoint<CR>
nmap <Leader>dr :DlvRemoveBreakpoint<CR>
nmap <Leader>dc :DlvClearAll<CR>

let b:ale_linters = ['gofmt', 'govet', 'gopls', 'golangci-lint']
let b:ale_fixers = ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace']

let g:ale_go_golangci_lint_options = '--config $HOME/fanatics-recommended-golangci.yml'

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
