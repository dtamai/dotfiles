" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

" Local config
if filereadable(fnamemodify("~/.gvimrc.local", ':p'))
  source ~/.gvimrc.local
endif