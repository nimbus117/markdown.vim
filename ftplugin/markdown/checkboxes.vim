command! -range -buffer
      \ MdCheckboxUnchecked
      \ <line1>,<line2>call markdown#checkboxes#set(0)

command! -range -buffer
      \ MdCheckboxChecked
      \ <line1>,<line2>call markdown#checkboxes#set(1)

command! -range -buffer
      \ MdCheckboxToggle
      \ <line1>,<line2>call markdown#checkboxes#toggle()

command! -range -buffer
      \ MdCheckboxRemove
      \ <line1>,<line2>call markdown#checkboxes#remove()
