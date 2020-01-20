let s:listChar = "-"
let s:checkedChar = "x"
let s:uncheckedChar = " "
let s:listRegEx = "^\\s*" . s:listChar . " "

function! markdown#lists#toggleCheckbox() abort
  if s:isChecked()
    call markdown#lists#removeCheckbox()
  else
    call markdown#lists#setCheckbox(s:hasCheckbox())
  endif
endfunction

function! markdown#lists#setCheckbox(checked) abort
  if s:isListItem()
    call markdown#lists#removeCheckbox()
    let l:mark = a:checked ? s:checkedChar : s:uncheckedChar
    execute "substitute/" . s:listRegEx . "/&[" . l:mark . "] "
  endif
endfunction

function! markdown#lists#removeCheckbox() abort
  if s:hasCheckbox()
    execute "substitute/" . s:listChar . " \\[.]/" . s:listChar
  endif
endfunction

function! s:isListItem() abort
  return markdown#helpers#matchLine(s:listRegEx)
endfunction

function! s:hasCheckbox() abort
  return markdown#helpers#matchLine(s:listRegEx . "\\[.] ")
endfunction

function! s:isChecked() abort
  return markdown#helpers#matchLine(s:listRegEx . "\\[" . s:checkedChar . "] ")
endfunction
