let s:atxRegEx = "^#\\{1,6}\\s"
let s:setextRegEx = ["^.\\+", "^[=|-]\\+$"]

" main functions {{{

function! markdown#headers#set(...) abort
  let l:lineNumber = line(".")
  let l:level = a:0 > 0 && a:1 > 0 ? a:1 <= 6 ? a:1 : 6 : 1
  if s:isHeader()
    call s:remove()
  endif
  if a:0 > 1 && a:2 == "atx" || l:level > 2
    call s:insertAtx(l:level)
  else
    call s:insertSetext(l:level)
  endif
  call cursor(l:lineNumber, 1)
endfunction

function! markdown#headers#increase() abort
  let l:level = s:getLevel()
  if s:isHeader() && l:level < 6 && l:level > 0
    call markdown#headers#set(l:level + 1)
  endif
endfunction

function! markdown#headers#decrease() abort
  let l:level = s:getLevel()
  if s:isHeader() && l:level > 1
    call markdown#headers#set(l:level - 1)
  endif
endfunction

function! markdown#headers#toggle() abort
  let l:level = s:getLevel()
  if l:level < 6
    call markdown#headers#set(l:level + 1)
  else
    call s:remove()
  endif
endfunction
" }}}

" helpers {{{

function! s:insertSetext(level) abort
  let l:character = a:level == 1 ? '=' : '-'
  let l:lineLength = strlen(getline("."))
  execute "normal! o" . l:lineLength . "i" . l:character
endfunction

function! s:insertAtx(level) abort
  execute "normal! "a:level . "I#a "
endfunction

function! s:remove() abort
  if s:isSetext()
    call s:removeSetext()
  elseif s:isAtx()
    call s:removeAtx()
  endif
endfunction

function! s:removeSetext() abort
  let l:view = winsaveview()
  let l:nextLine = line('.') + 1
  execute l:nextLine . ":delete _"
  call winrestview(l:view)
endfunction

function! s:removeAtx() abort
  execute "substitute/" . s:atxRegEx . "/"
endfunction

function! s:getLevel() abort
  if markdown#helpers#matchLine("^=\\+$", line('.') + 1)
    return 1
  elseif markdown#helpers#matchLine("^-\\+$", line('.') + 1)
    return 2
  elseif s:isAtx()
    let l:line = getline('.')
    return len(split(l:line, " ")[0])
  else
    return 0
  endif
endfunction

function! s:isHeader() abort
  return s:isSetext() || s:isAtx()
endfunction

function! s:isSetext() abort
  return markdown#helpers#matchLine(s:setextRegEx[0]) &&
        \ markdown#helpers#matchLine(s:setextRegEx[1], line('.') + 1)
endfunction

function! s:isAtx() abort
  return markdown#helpers#matchLine(s:atxRegEx)
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
