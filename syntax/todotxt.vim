if exists("b:current_syntax")
  finish
endif

" Contexts (e.g. `@context`).
syntax match todotxtContext ' \@<=@\S\+'

" Projects (e.g. `+project`).
syntax match todotxtProject ' \@<=+\S\+'

" Due dates (e.g. `due:2020-05-07`).
syntax match todotxtDueDate 'due:\d\d\d\d-\d\d-\d\d\($\| \@=\)'

" Completed tasks.
syntax match todotxtDone '^x\s.\+$'

let s:priorities = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"]
for s:x in s:priorities
  execute "syn match todotxtPri" . s:x . " '^(" . s:x . ")\\s.\\+$' contains=todotxtContext,todotxtProject,todotxtDueDate"
endfor

let b:current_syntax = "todotxt"

let s:priority_colors = {
      \ "A": "ctermfg=1 cterm=bold",
      \ "B": "ctermfg=4 cterm=bold",
      \ "C": "ctermfg=5 cterm=bold",
      \ "D": "ctermfg=6 cterm=bold",
      \ "E": "ctermfg=4",
      \ "F": "ctermfg=5",
      \ "G": "ctermfg=6",
      \ }

highlight default todotxtContext cterm=italic ctermfg=3
highlight default todotxtProject cterm=italic ctermfg=2
highlight default todotxtDueDate cterm=italic ctermfg=1
highlight default todotxtDone ctermfg=8
for s:x in s:priorities
  if has_key(s:priority_colors, s:x)
    execute "hi def todotxtPri" . s:x . " " . get(s:priority_colors, s:x)
  else
    break
  endif
endfor

