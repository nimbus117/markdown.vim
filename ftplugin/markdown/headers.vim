command! -buffer
      \ -complete=customlist,markdown#headers#insertCompletion
      \ -nargs=*
      \ MdHeader
      \ call markdown#headers#set(<f-args>)

command! -buffer
      \ MdHeaderToggle
      \ call markdown#headers#toggle()

command! -range -buffer
      \ MdHeaderIncrease
      \ call markdown#headers#increase(<line1>,<line2>)

command! -range -buffer
      \ MdHeaderDecrease
      \ call markdown#headers#decrease(<line1>,<line2>)

command! -range -buffer
      \ MdHeaderRemove
      \ call markdown#headers#remove(<line1>,<line2>)
