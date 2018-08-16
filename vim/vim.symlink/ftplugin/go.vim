set tabstop=8
set nosmarttab
set shiftwidth=8
set noexpandtab

" run goimports on save/fmt
let g:go_fmt_command = "goimports"

" run gometalinter on save
let g:go_metalinter_autosave = 1

" Run commands such as go run for the current file with <leader>r or go build and go test for the current package with <leader>b and <leader>t respectively. Display beautifully annotated source code to see which functions are covered with <leader>c.
nmap <leader>r <Plug>(go-run)
nmap <leader>b <Plug>(go-build)
"nmap <leader>t <Plug>(go-test)
nmap <leader>c <Plug>(go-coverage-toggle)

" By default the mapping gd is enabled, which opens the target identifier in current buffer. You can also open the definition/declaration, in a new vertical, horizontal, or tab, for the word under your cursor:
nmap <Leader>ds <Plug>(go-def-split)
nmap <Leader>dv <Plug>(go-def-vertical)
nmap <Leader>dt <Plug>(go-def-tab)

" Open the relevant Godoc for the word under the cursor with <leader>gd or open it vertically with <leader>gv
nmap <Leader>gd <Plug>(go-doc)
nmap <Leader>gv <Plug>(go-doc-vertical)

" Or open the Godoc in browser
nmap <Leader>gb <Plug>(go-doc-browser)

" Show a list of interfaces which is implemented by the type under your cursor with <leader>s
nmap <Leader>s <Plug>(go-implements)

" Show type info for the word under your cursor with <leader>i (useful if you have disabled auto showing type info via g:go_auto_type_info)
nmap <Leader>i <Plug>(go-info)

" Rename the identifier under the cursor to a new name
nmap <Leader>e <Plug>(go-rename)

" Tests
nmap <Leader>t :TestNearest -v <CR>
nmap <Leader>T :TestSuite <CR>

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
