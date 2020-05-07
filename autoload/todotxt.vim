" Utility functions

function! s:get_current_date()
  return strftime('%Y-%m-%d')
endfunction

" Marking tasks as done

function todotxt#undo()
  s/^\(x \(\d\d\d\d-\d\d-\d\d \(\d\d\d\d-\d\d-\d\d \)\@=\)\?\)\?/
endfunction

function todotxt#do()
  execute 's/^\(\(([A-Z])\) \)\?/x ' . s:get_current_date() . ' /'
endfunction

function todotxt#toggleDo()
  if getline('.') =~ '^x'
    call todotxt#undo()
  else
    call todotxt#do()
  endif
endfunction

" Setting task priorities

function todotxt#unpri()
  s/^\(([A-Z]) \)\?/
endfunction

function todotxt#pri(p)
  let l:pUpper = toupper(a:p)
  if l:pUpper =~ '^[A-Z]$'
    call todotxt#unpri()
    call todotxt#undo()
    execute 's/^/(' . l:pUpper . ') /'
  else
    " TODO: is there an actual way to make it not accept non-letter arguments?
    echohl ErrorMsg
    echomsg "todotxt#pri: Argument must a be a letter."
    echohl None
  endif
endfunction

function todotxt#inputPri(p = v:null)
  call todotxt#pri(a:p == v:null ? input("Enter priority: ") : a:p)
endfunction

function todotxt#maybePri(p)
  if a:p == ''
    call todotxt#unpri()
  else
    call todotxt#pri(a:p)
  endif
endfunction

function todotxt#inputMaybePri(p = v:null)
  let l:setP = a:p == v:null ? input("Enter priority or blank to remove: ") : a:p
  if l:setP == ''
    call todotxt#unpri()
  else
    call todotxt#pri(l:setP)
  endif
endfunction
