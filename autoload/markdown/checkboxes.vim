let s:listChar = "-"
let s:checkedChar = "x"
let s:uncheckedChar = " "

let s:listRegEx = "^\\s*" . s:listChar . "\\s"
let s:numberedListRegEx = "^\\s*\\d\\+\\.\\s"
let s:eitherListRegEx = "\\(" . s:listRegEx . "\\|" . s:numberedListRegEx . "\\)" 

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
    execute "substitute/" . s:eitherListRegEx . "/&[" . l:mark . "] "
  endif
endfunction

function! markdown#checkboxes#remove() abort
  if s:hasCheckbox()
    execute "substitute/\\s\\[.]//"
  endif
endfunction
" }}}

" helpers {{{

function! s:isListItem() abort
  return markdown#helpers#matchLine(s:eitherListRegEx)
endfunction

function! s:hasCheckbox() abort
  return markdown#helpers#matchLine(s:eitherListRegEx . "\\[.]\\s")
endfunction

function! s:isChecked() abort
  return markdown#helpers#matchLine(s:eitherListRegEx . "\\[" . s:checkedChar . "]\\s")
endfunction
" }}}
