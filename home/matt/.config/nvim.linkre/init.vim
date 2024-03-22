set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require("lsp")
lua require("copilot")

" format go files on save
autocmd BufWritePre *.go lua vim.lsp.buf.format()
