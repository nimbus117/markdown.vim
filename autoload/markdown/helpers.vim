function! markdown#helpers#matchLine(regex) abort
  return getline(".") =~# a:regex ? 1 : 0
endfunction
