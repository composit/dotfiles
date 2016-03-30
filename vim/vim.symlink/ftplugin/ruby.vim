
" Open javascript files
map <leader>j :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
" map <leader>j :CtrlP app/assets/javascripts/angular<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>t :call RunTestFile()<cr>
map <leader>a :call RunTests('')<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(._spec.js.coffee\|_spec.rb\|_test.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    if match(expand("%"), '.js.coffee$') != -1
      let t:grb_test_file=@%
    else
      let t:grb_test_file=@% . ":" . line('.')
    end
endfunction

function! RunTests(filename)
    :w
    if match(expand("%"), '.js.coffee$') != -1
        exec ":!jasmine-headless-webkit --color --no-full-run --runner-out runner.html " . a:filename
    else
        call system("tmux send-keys -t tests C-z 'zeus test " . a:filename ."' C-m")
        call system("tmux select-window -t tests")
    end
endfunction

function! OldRunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(expand("%"), '.js.coffee$') != -1
        exec ":!jasmine-headless-webkit --color --no-full-run --runner-out runner.html " . a:filename
    else
        if match(expand("%"), '^test/') != -1
            "exec ":Dispatch zeus test " . a:filename
            exec ":tmux send-keys -t 'tests' C-z 'zeus test " . a:filename . "' C-r"
        else
            exec ":Dispatch zeus test " . a:filename
        end
        " if filereadable("Gemfile")
        "     "exec ":!bundle exec rspec --color --drb " . a:filename
        "     exec ":!bundle exec spec --color --drb " . a:filename
        " else
        "     "exec ":!rspec --color --drb " . a:filename
        "     exec ":!spec --color --drb " . a:filename
        "end
    end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN TEST OR PRODUCTION CODE IN SPLIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':vsp ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let in_test = match(current_file, '^test/') != -1
  let in_js = match(current_file, '\<javascripts\>') != -1
  let in_ruby = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1 || match(current_file, '\<mailers\>') != -1 || match(current_file, '\<api\>') != -1
  if in_spec || in_test
    if in_js
      let new_file = substitute(new_file, '_spec\.js\.coffee$', '.js.coffee', '')
      let new_file = 'app/assets/' . new_file
    elseif in_spec
      let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
      let new_file = substitute(new_file, '^spec/', '', '')
    elseif in_test
      let new_file = substitute(new_file, '_test\.rb$', '.rb', '')
      let new_file = substitute(new_file, '^test/unit/', 'app/models/', '')
      let new_file = substitute(new_file, '^test/functional/', 'app/controllers/', '')
    end
    if in_ruby
      let new_file = 'app/' . new_file
    end
  else
    if in_js
      let new_file = substitute(new_file, '^app/assets/', '', '')
      let new_file = substitute(new_file, '\.js\.coffee$', '_spec.js.coffee', '')
      let new_file = 'spec/' . new_file
    elseif filereadable("test/test_helper.rb")
      let new_file = substitute(new_file, '^app/models', 'test/unit', '')
      let new_file = substitute(new_file, '^app/controllers', 'test/functional', '')
      let new_file = substitute(new_file, '\.rb$', '_test.rb', '')
    elseif in_ruby
      let new_file = substitute(new_file, '^app/', '', '')
      let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
      let new_file = 'spec/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>
