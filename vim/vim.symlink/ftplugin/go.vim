<<<<<<< HEAD
set tabstop=8
set nosmarttab
set shiftwidth=8
set noexpandtab
=======
let g:go_fmt_command = "goimports"

" Run commands such as go run for the current file with <leader>r or go build and go test for the current package with <leader>b and <leader>t respectively. Display beautifully annotated source code to see which functions are covered with <leader>c.
nmap <leader>r <Plug>(go-run)
nmap <leader>b <Plug>(go-build)
nmap <leader>t <Plug>(go-test)
nmap <leader>c <Plug>(go-coverage)

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
>>>>>>> 8f3f103048c4ed7c3244616a4d8b4a3e291f5214
