let s:atxRegEx = "^#\\{1,6}\\s"
let s:setextRegEx = ["^.\\+", "^[=|-]\\+$"]

" main functions {{{

function! markdown#headers#set(...) abort
  let l:lineNumber = line(".")
  let l:level = a:0 > 0 && a:1 > 0 ? a:1 <= 6 ? a:1 : 6 : 1
  if s:isHeader()
    call markdown#headers#remove()
  endif
  if a:0 > 1 && a:2 == "atx" || l:level > 2
    call s:insertAtx(l:level)
  else
    call s:insertSetext(l:level)
  endif
  call cursor(l:lineNumber, 1)
endfunction

function! markdown#headers#toggle() abort
  let l:level = s:getLevel()
  if l:level < 6
    call markdown#headers#set(l:level + 1)
  else
    call markdown#headers#remove()
  endif
endfunction

function! markdown#headers#increase(...) abort
  let l:current = a:0 > 0 ? a:1 : line('.')
  let l:end = a:0 > 1 ? a:2 : line('.')

  while l:current <= l:end
    call cursor(l:current, 1)
    let l:level = s:getLevel()
    if s:isHeader() && l:level < 6 && l:level > 0
      if s:isSetext()
        let l:end = l:end - 1
      endif
      call markdown#headers#set(l:level + 1)
    endif
    let l:current = l:current + 1
  endwhile
endfunction

function! markdown#headers#decrease(...) abort
  let l:current = a:0 > 0 ? a:1 : line('.')
  let l:end = a:0 > 1 ? a:2 : line('.')

  while l:current <= l:end
    call cursor(l:current, 1)
    let l:level = s:getLevel()
    if s:isHeader() && l:level > 1
      if s:isSetext()
        let l:end = l:end - 1
      endif
      call markdown#headers#set(l:level - 1)
    endif
    let l:current = l:current + 1
  endwhile
endfunction

function! markdown#headers#remove(...) abort
  let l:current = a:0 > 0 ? a:1 : line('.')
  let l:end = a:0 > 1 ? a:2 : line('.')

  while l:current <= l:end
    call cursor(l:current, 1)
    if s:isSetext()
      call s:removeSetext()
      let l:end = l:end - 1
    elseif s:isAtx()
      call s:removeAtx()
    endif
    let l:current = l:current + 1
  endwhile
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

function! markdown#headers#insertCompletion(ArgLead, CmdLine, CursorPos) abort
  let l:argCount = len(split(a:CmdLine, " "))
  if l:argCount == 1
    return ["1","2","3","4","5","6"]
  elseif l:argCount == 2
    return ["atx", "setext"]
  endif
endfunction
" }}}
