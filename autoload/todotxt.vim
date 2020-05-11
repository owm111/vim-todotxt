" Utility functions

function! s:get_current_date()
  return strftime('%Y-%m-%d')
endfunction

" Marking tasks as done

function todotxt#undo(line)
  return substitute(a:line, '^\(x \(\d\d\d\d-\d\d-\d\d \(\d\d\d\d-\d\d-\d\d \)\@=\)\?\)\?', '', '')
endfunction

function todotxt#do(line)
  return substitute(a:line, '^\(\(([A-Z)\) \)\?', 'x ' . s:get_current_date() . ' ', '')
endfunction

function todotxt#toggleDo(line)
  if a:line[0] == 'x'
    return todotxt#undo(a:line)
  else
    return todotxt#do(a:line)
  endif
endfunction

" Setting task priorities

function todotxt#unpri(line)
  return substitute(a:line, '^\(([A-Z]) \)\?', '', '')
endfunction

function todotxt#pri(p, line)
  let l:pUpper = toupper(a:p)
  if l:pUpper =~ '^[A-Z]$'
    return todotxt#unpri(a:line)->todotxt#undo()->{ x -> substitute(x, '^', '(' . l:pUpper . ') ') }
  else
    " TODO: is there an actual way to make it not accept non-letter arguments?
    echohl ErrorMsg
    echomsg "todotxt#pri: Argument must a be a letter."
    echohl None
  endif
endfunction

function todotxt#maybePri(p, line)
  return a:p == '' ? a:line->todotxt#unpri() : a:line->todotxt#pri(a:p)
endfunction
