let s:listChar = "-"
let s:checkedChar = "x"
let s:uncheckedChar = " "
let s:listRegEx = "^\\s*" . s:listChar . " "

" main functions {{{

function! markdown#checkboxes#toggle() abort
  if s:isChecked()
    call markdown#checkboxes#remove()
  else
    call markdown#checkboxes#set(s:hasCheckbox())
  endif
endfunction

function! markdown#checkboxes#set(checked) abort
  if s:isListItem()
    call markdown#checkboxes#remove()
    let l:mark = a:checked ? s:checkedChar : s:uncheckedChar
    execute "substitute/" . s:listRegEx . "/&[" . l:mark . "] "
  endif
endfunction

function! markdown#checkboxes#remove() abort
  if s:hasCheckbox()
    execute "substitute/" . s:listChar . " \\[.]/" . s:listChar
  endif
endfunction
" }}}

" helpers {{{

function! s:isListItem() abort
  return markdown#helpers#matchLine(s:listRegEx)
endfunction

function! s:hasCheckbox() abort
  return markdown#helpers#matchLine(s:listRegEx . "\\[.] ")
endfunction

function! s:isChecked() abort
  return markdown#helpers#matchLine(s:listRegEx . "\\[" . s:checkedChar . "] ")
endfunction
" }}}
