function! s:insertHeader(...) abort
  let l:view = winsaveview()
  let l:level = a:0 > 0 && a:1 > 0 ? a:1 <= 6 ? a:1 : 6 : 1
  if a:0 > 1 && a:2 == "atx" || l:level > 2
    call s:atxHeader(l:level)
    let l:view["col"] = l:view["col"] + l:level + 1
  else
    let l:character = l:level == 1 ? "=" : "-"
    call s:underlineWith(l:character)
  endif
  call winrestview(l:view)
endfunction

function! s:underlineWith(character) abort
  let l:lineLength = strlen(getline("."))
  if l:lineLength > 0
    execute "normal! o" . l:lineLength . "i" . a:character
  endif
endfunction

function! s:atxHeader(level) abort
  execute "normal! "a:level . "I#a "
endfunction

function! s:headerCompletion(ArgLead,CmdLine,CursorPos) abort
  if a:CursorPos == 9
    return ["1","2","3","4","5","6"]
  elseif a:CursorPos > 10
    return ["atx", "setext"]
  endif
endfunction

function! s:isSetextHeader() abort

endfunction

function! s:isAtxHeader() abort

endfunction

function! s:removeHeader() abort
  if s:isSetextHeader()

  elseif s:isAtxHeader()

  endif
endfunction

function! s:toggleHeader(...) abort

endfunction

command! -buffer -complete=customlist,s:headerCompletion -nargs=* MdHeader call s:insertHeader(<f-args>)
