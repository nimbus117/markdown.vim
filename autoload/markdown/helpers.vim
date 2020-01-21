function! markdown#helpers#matchLine(regex, ...) abort
  let l:lineNumber = a:0 > 0 && a:1 > 0 ? a:1 : '.'
  return getline(l:lineNumber) =~# a:regex ? 1 : 0
endfunction
