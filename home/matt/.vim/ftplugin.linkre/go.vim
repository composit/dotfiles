if exists('Enable_coding_plugins')
       call Enable_coding_plugins()
endif

packadd vim-delve

setlocal tabstop=8
setlocal nosmarttab
setlocal shiftwidth=8
setlocal noexpandtab
setlocal textwidth=100

let b:ale_linters = ['gofmt', 'govet', 'gopls', 'golangci-lint']
let b:ale_fixers = ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace', 'gofumpt', 'golines', 'gopls']
let g:ale_go_golangci_lint_options = '--config $HOME/golangci.yml'
let g:ale_go_golines_options = '--no-chain-split-dots --no-reformat-tags'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t :call RunTestFunc()<cr>
map <leader>T :call RunAllTests()<cr>

let s:tmux_session = 'notes'
let s:tmux_window = 'tests'

function! RunAllTests()
  call TmuxSend("go test ./...")
endfunction

" taken from https://github.com/tyru/current-func-info.vim/blob/893c964f7d5692fe1ea114667869858503fc903a/ftplugin/go/cfi.vim#L17
" \C makes it case insensitive
" \> matches the end of a word
" \%(\) searches for escaped parentheses without making it a sub-expression
let s:FUNC_PATTERN = '\C^\s*func\s\+Test\(\w\+\)\s*('
let s:SCENARIO_PATTERN = '\vt\.Run\("([^"]+)",\s*func\(\)\s*\{'
let s:SCENARIO_PATTERN = '\v^\s*t\.Run\("([^"]+)",\s*func\(\s*t\s*\*\s*testing\.T\s*\)\s*\{'
let s:METHOD_PATTERN = '\C^\s*func\s\+(\w\s\+\*\w\+)\s\+Test\(\w\+\)\s*('

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

function! OldFuncName()
  let m = matchlist(getline(search(s:FUNC_PATTERN, 'bWn')), s:FUNC_PATTERN)
  if empty(m)
    return ''
  endif

  return m[1].m[2].s
endfunction

function! FuncName()
  " Get the current line number
  let lnum = line('.')
  let method = ''
  let scenario = ''

  while lnum > 0
    let line = getline(lnum)

    if method == '' " only find the nearest method
      " Search for the method pattern from the current line upwards
      let m = matchlist(line, s:METHOD_PATTERN)
      if !empty(m)
	" If a match is found, set the method name prepended with a slash
	let method = '$/'.m[1]
      endif
    endif

    if scenario == '' " only find the nearest scenario
      " Search for the t.Run pattern from the current line upwards
      let m = matchlist(line, s:SCENARIO_PATTERN)
      if !empty(m)
        " If a match is found, set the scenario name prepended with a slash
        let scenario = '$/'.m[1]
      endif
    endif

    " find the function name
    let m = matchlist(line, s:FUNC_PATTERN)
    if !empty(m)
      " If a match is found, return the function
      " and scenario names (if a scenario was found)
      " and method name (if a method was found)
      return m[1].m[2].method.scenario
    endif

    let lnum -= 1
  endwhile

  " If no match is found, return an empty string
  return ''
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
map <leader>vx :call DebugExit()<cr>
map <leader>vb :call DebugSetBreakpoint()<cr>
map <leader>va :call DebugClearall()<cr>
map <leader>vv :call DebugTestBreakpoint()<cr>
map <leader>vr :call DebugRunBreakpoint()<cr>

function! DebugClearall()
  call TmuxSend("clearall")
endfunction

function! DebugSetBreakpoint()
  call TmuxSend("break " . @% . ":" . line("."))
  call DebugContinue()
endfunction

function! DebugContinue()
  call TmuxSend("continue")
endfunction

function! DebugExit()
  call TmuxSend("exit")
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

function! DebugRun()
  :w
  call TmuxSend("dlv debug")
endfunction

function! DebugTestBreakpoint()
  call DebugTestFunc()
  call DebugSetBreakpoint()
endfunction

function! DebugRunBreakpoint()
  call DebugRun()
  call DebugSetBreakpoint()
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
