" main functions {{{

function! markdown#headers#insert(...) abort
  let l:view = winsaveview()
  let l:level = a:0 > 0 && a:1 > 0 ? a:1 <= 6 ? a:1 : 6 : 1
  if a:0 > 1 && a:2 == "atx" || l:level > 2
    call s:insertAtxHeader(l:level)
    let l:view["col"] = l:view["col"] + l:level + 1
  else
    let l:character = l:level == 1 ? "=" : "-"
    call s:underlineWith(l:character)
  endif
  call winrestview(l:view)
endfunction

function! markdown#headers#set(...) abort

endfunction

function! markdown#headers#remove() abort
  if s:isSetext()

  elseif s:isAtx()

  endif
endfunction

function! markdown#headers#toggle(...) abort

endfunction
" }}}

" helpers {{{

function! s:underlineWith(character) abort
  let l:lineLength = strlen(getline("."))
  if l:lineLength > 0
    execute "normal! o" . l:lineLength . "i" . a:character
  endif
endfunction

function! s:insertAtxHeader(level) abort
  execute "normal! "a:level . "I#a "
endfunction

function! s:isSetext() abort

endfunction

function! s:isAtx() abort

endfunction
" }}}

" command completion {{{

function! markdown#headers#insertCompletion(ArgLead,CmdLine,CursorPos) abort
  if a:CursorPos == 9
    return ["1","2","3","4","5","6"]
  elseif a:CursorPos > 10
    return ["atx", "setext"]
  endif
endfunction
" }}}
