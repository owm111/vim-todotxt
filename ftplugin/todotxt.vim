" Utility functions

function s:applyToRange(line1, line2, f) " This function is impure!!
  for l:i in range(a:line1, a:line2)
    call getline(l:i)->a:f()->setline(l:i)
  endfor
endfunction

" Runs |todotxt#undo| on the current line (or range).
command -buffer -range TodotxtUndo
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#undo(x)     })

" Runs |todotxt#do| on the current line (or range).
command -buffer -range TodotxtDo
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#do(x)       })

" Runs |todotxt#toggleDo| on the current line (or range).
command -buffer -range TodotxtToggleDo
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#toggleDo(x) })

" Runs |todotxt#unpri| on the current line (or range).
command -buffer -range TodotxtUnpri
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#unpri(x)    })

" Runs |todotxt#pri| on the current line (or range). The priority can be
" specified as an argument or input.
command -buffer -range -nargs=? TodotxtInputPri
      \ call s:applyToRange(<line1>, <line2>, { x ->
      \ todotxt#pri(<q-args> == '' ? input('Enter priority: ') : <q-args>, x) })

" Runs |todotxt#maybePri| on the current line (or range). The priority can be
" specified as an argument or input.
command -buffer -range -nargs=? TodotxtInputMaybePri
      \ call s:applyToRange(<line1>, <line2>, { x ->
      \ todotxt#maybePri(<q-args> == '' ? input('Enter priority or blank to remove: ') : <q-args>, x) })
