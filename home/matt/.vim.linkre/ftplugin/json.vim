call Enable_coding_plugins()

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal tabstop=2
setlocal softtabstop=0
setlocal expandtab
setlocal shiftwidth=2
setlocal smarttab
