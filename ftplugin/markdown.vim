" enable spell checking
setlocal spell
" break lines after 80 characters, after whitespace
setlocal textwidth=80 
" enable markdown folding but start with folds disabled
let g:markdown_folding = 1 
setlocal nofoldenable
" settings for https://github.com/plasticboy/vim-markdown
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_toc_autofit = 1

" markdownHeader() - insert a markdown header (defaults to setext style h1) {{{
function! s:markdownHeader(...) abort
  let l:view = winsaveview()
  let l:level = a:0 > 0 && a:1 > 0 ? a:1 <= 6 ? a:1 : 6 : 1
  if a:0 > 1 && a:2 == 'atx' || l:level > 2
    call s:atxHeader(l:level)
    let l:view['col'] = l:view['col'] + l:level + 1
  else
    let l:character = l:level == 1 ? '=' : '-'
    call s:underlineWith(l:character)
  endif
  call winrestview(l:view)
endfunction

function! s:underlineWith(character) abort
  let l:lineLength = strlen(getline('.'))
  execute "normal! o" . l:lineLength . "i" . a:character
endfunction

function! s:atxHeader(level) abort
  execute "normal! "a:level . "I#a "
endfunction

function! s:headerCompletion(ArgLead,CmdLine,CursorPos)
  if a:CursorPos == 9
    return ['1','2','3','4','5','6']
  elseif a:CursorPos > 10
    return ['atx', 'setext']
  endif
endfunction

command! -complete=customlist,s:headerCompletion -nargs=* MdHeader call s:markdownHeader(<f-args>)
" }}}
