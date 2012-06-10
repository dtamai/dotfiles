function! s:LocalRC()
  if has('win32')
    return ($HOME."\_gvimrc.local")
  else
    return ($HOME."/.gvimrc.local")
  end
endfunction

" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

" Local configurations
let s:local = s:LocalRC()
if filereadable(s:local)
  exec "source " . s:local
  let $MY_LOCAL_GVIMRC = s:LocalRC()
end
