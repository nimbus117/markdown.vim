command! -range -buffer
      \ MdCheckboxToggle
      \ <line1>,<line2>call markdown#lists#toggleCheckbox()

command! -range -buffer
      \ MdCheckboxRemove
      \ <line1>,<line2>call markdown#lists#removeCheckbox()

command! -range -buffer
      \ MdCheckboxChecked
      \ <line1>,<line2>call markdown#lists#setCheckbox(1)

command! -range -buffer
      \ MdCheckboxUnchecked
      \ <line1>,<line2>call markdown#lists#setCheckbox(0)
