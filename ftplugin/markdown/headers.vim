command! -buffer
      \ -complete=customlist,markdown#headers#insertCompletion
      \ -nargs=*
      \ MdHeader
      \ call markdown#headers#insert(<f-args>)
