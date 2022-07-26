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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t :call RunTestFunc()<cr>
map <leader>T :call RunAllTests()<cr>

let s:tmux_session = 'notes'
let s:tmux_window = 'tests'

function! RunAllTests()
  call TmuxSend("go test -v ./...")
endfunction

" taken from https://github.com/tyru/current-func-info.vim/blob/893c964f7d5692fe1ea114667869858503fc903a/ftplugin/go/cfi.vim#L17
" \C makes it case insensitive
" \> matches the end of a word
" \%(\) searches for escaped parentheses without making it a sub-expression
let s:FUNC_PATTERN = '\C'.'^\s*'.'func\>'.'\s\+'.'\((\w\+\s\+[^)]\+)\s\+\)\='.'\('.'[^(]\+'.'\)'.'\%('.'\s*'.'('.'\=\)'

function! RunTestFunc()
  " Run the tests for the previously-marked func.
  let in_test_func = match(expand("%"), '\(.*_test.go\)$') != -1

  if in_test_func
    call SetTestFunc()
  elseif !exists("t:grb_test_func")
    return
  end

  call RunTests(t:grb_test_dir, t:grb_test_func)
endfunction

function! FuncName()
  let m = matchlist(getline(search(s:FUNC_PATTERN, 'bWn')), s:FUNC_PATTERN)
  if empty(m)
    return ''
  endif

  return m[1].m[2]
endfunction

function! SetTestFunc()
  " Set the test func that tests will be run for.
  let t:grb_test_dir = "./" . expand("%:h")
  let t:grb_test_func = FuncName()
endfunction

function! RunTests(dir, func)
  :w
  call TmuxSend("go test -v -run '" . a:func . "$' " . a:dir)
endfunction

function! TmuxSend(cmd)
  call system("tmux send-keys -t '" . s:tmux_session . ":" . s:tmux_window . "' \"" . a:cmd . "\" C-m")
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DEBUGGING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>vt :call DebugTestFunc()<cr>
map <leader>vc :call DebugContinue()<cr>
map <leader>vb :call DebugSetBreakpoint()<cr>
map <leader>vr :call DebugRebuild()<cr>

function! DebugRebuild()
  call TmuxSend("rebuild")
endfunction

function! DebugSetBreakpoint()
  call TmuxSend("break " . expand("%") . ":" . line("."))
endfunction

function! DebugContinue()
  call TmuxSend("continue")
endfunction

function! DebugTestFunc()
  " Run the tests for the previously-marked func.
  let in_test_func = match(expand("%"), '\(.*_test.go\)$') != -1

  if in_test_func
    call SetTestFunc()
  elseif !exists("t:grb_test_func")
    return
  end

  call DebugTests(t:grb_test_dir, t:grb_test_func)
endfunction

function! DebugTests(dir, func)
  :w
  call TmuxSend("dlv test " . a:dir . " -- -test.v -test.run '" . a:func . "$'")
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN TEST OR PRODUCTION CODE IN SPLIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

nnoremap <leader>. :call OpenTestAlternate()<cr>
