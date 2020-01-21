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
      \ <line1>,<line2>call markdown#headers#increase()

command! -range -buffer
      \ MdHeaderDecrease
      \ <line1>,<line2>call markdown#headers#decrease()
