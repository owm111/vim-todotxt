" Utility functions

function! s:get_current_date()
  return strftime('%Y-%m-%d')
endfunction

" Functions should be pure and uncurried. The former because impure code is
" gross; the latter because the -> syntax and lambdas can fill a similar
" purpose while remaining more simple.

" Removes a priority (`([A-Z]) \@=`) and leading spaces from {line}.
function todotxt#unpri(line)
  return substitute(a:line, '^\(([A-Z]) \+\)\?', '', '')
endfunction

" Removes an x from the beginning of {line}. If two dates are specified,
" then the first is removed.
function todotxt#undo(line)
  return substitute(a:line, '^\(x \(\d\d\d\d-\d\d-\d\d \(\d\d\d\d-\d\d-\d\d \)\@=\)\?\)\?', '', '')
endfunction

" Removes a priority from {line}, then prepends an x and the date (if a
" creation date is already specified).
function todotxt#do(line)
  return todotxt#unpri(a:line)->{ x -> 'x ' . (x =~ '^\d\d\d\d-\d\d-\d\d ' ? s:get_current_date() . ' ' : '') . x }()
endfunction

" If a {line} begins with an 'x ', then |todotxt#undo| is called, else
" |todotxt#do| is called.
function todotxt#toggleDo(line)
  return a:line[0:1] == 'x ' ? todotxt#undo(a:line) : todotxt#do(a:line)
endfunction

" Calls |todotxt#unpri| and |todotxt#undo| on a {line}, then prepends a
" priority letter and a space. Will fail if not provided a letter for the
" priority argument.
function todotxt#pri(p, line)
  let l:pUpper = toupper(a:p)
  if l:pUpper =~ '^[A-Z]$'
    return todotxt#unpri(a:line)->todotxt#undo()->{ x -> '(' . l:pUpper . ') ' . x }()
  else
    " TODO: is there an actual way to make it not accept non-letter arguments?
    echohl ErrorMsg
    echomsg "todotxt#pri: Argument must a be a letter."
    echohl None
  endif
endfunction

" If provided an empty string as a {p}, then runs |todotxt#unpri|, else
" runs |todotxt#pri| with the {p}.
function todotxt#maybePri(p, line)
  return a:p == '' ? a:line->todotxt#unpri() : a:line->todotxt#pri(a:p)
endfunction
