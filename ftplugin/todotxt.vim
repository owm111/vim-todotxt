" Utility functions

function s:applyToRange(line1, line2, f) " This function is impure!!
  for l:i in range(a:line1, a:line2)
    call getline(l:i)->a:f()->setline(l:i)
  endfor
endfunction

" Marking tasks as done

command -buffer -range TodotxtUndo
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#undo(x)     })
command -buffer -range TodotxtDo
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#do(x)       })
command -buffer -range TodotxtToggleDo
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#toggleDo(x) })

" Setting task priorities

command -buffer -range          TodotxtUnpri
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#unpri(x)              })
command -buffer -range -nargs=1 TodotxtPri
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#pri(x, <q-args>)      })
command -buffer -range -nargs=1 TodotxtMaybePri
      \ call s:applyToRange(<line1>, <line2>, { x -> todotxt#maybePri(x, <q-args>) })

" Variadically setting task priorities

command -buffer -range -nargs=? TodotxtInputPri
      \ call s:applyToRange(<line1>, <line2>, { x ->
      \ todotxt#pri(<q-args> == '' ? input('Enter priority: ') : <q-args>, x) })

command -buffer -range -nargs=? TodotxtInputMaybePri
      \ call s:applyToRange(<line1>, <line2>, { x ->
      \ todotxt#pri(<q-args> == '' ? input('Enter priority or blank to remove: ') : <q-args>, x) })
