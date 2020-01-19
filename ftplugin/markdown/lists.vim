let s:listChar = "-"
let s:checkedChar = "x"
let s:uncheckedChar = " "
let s:listRegEx = "^\\s*" . s:listChar . " "

function! s:toggleCheckbox() abort
  if s:isChecked()
    call s:removeCheckbox()
  else
    call s:setCheckbox(s:hasCheckbox())
  endif
endfunction

function! s:setCheckbox(checked) abort
  if s:isListItem()
    call s:removeCheckbox()
    let l:mark = a:checked ? s:checkedChar : s:uncheckedChar
    execute "substitute/" . s:listRegEx . "/&[" . l:mark . "] "
  endif
endfunction

function! s:removeCheckbox() abort
  if s:hasCheckbox()
    execute "substitute/" . s:listChar . " \\[.]/" . s:listChar
  endif
endfunction

function! s:isListItem() abort
  return s:matchCurrentLine(s:listRegEx)
endfunction

function! s:hasCheckbox() abort
  return s:matchCurrentLine(s:listRegEx . "\\[.] ")
endfunction

function! s:isChecked() abort
  return s:matchCurrentLine(s:listRegEx . "\\[" . s:checkedChar . "] ")
endfunction

function! s:matchCurrentLine(regex) abort
  return getline(".") =~# a:regex ? 1 : 0
endfunction

command! -range -buffer MdCheckboxToggle <line1>,<line2>call s:toggleCheckbox()
command! -range -buffer MdCheckboxRemove <line1>,<line2>call s:removeCheckbox()
command! -range -buffer MdCheckboxChecked <line1>,<line2>call s:setCheckbox(1)
command! -range -buffer MdCheckboxUnchecked <line1>,<line2>call s:setCheckbox(0)
