setlocal textwidth=80 
setlocal spell

let g:markdown_folding = 1 

function! s:underlineWith(character) abort
  let l:lineLength = strlen(getline('.'))
  execute "normal! o" . l:lineLength . "i" . a:character
endfunction

function! s:atxHeaders(level) abort
  execute "normal! "a:level . "I#a "
endfunction

" insert a markdown header (defaults to setext style h1)
function s:markdownHeader(...) abort
  let l:level = a:0 > 0 && a:1 > 0 ? a:1 <= 6 ? a:1 : 6 : 1
  if a:0 > 1 && a:2 == 'atx' || l:level > 2
    call s:atxHeaders(l:level)
  else
    let l:character = l:level == 1 ? '=' : '-'
    call s:underlineWith(l:character)
  endif
endfunction

function s:headerCompletion(ArgLead,CmdLine,CursorPos)
  if a:CursorPos == 9
    return ['1','2','3','4','5','6']
  elseif a:CursorPos > 10
    return ['atx', 'setext']
  endif
endfunction

command! -complete=customlist,s:headerCompletion -nargs=* MdHeader call s:markdownHeader(<f-args>)
