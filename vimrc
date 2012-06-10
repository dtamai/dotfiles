function! s:LocalRC()
  if has('win32')
    return ($HOME."\_vimrc.local")
  else
    return ($HOME."/.vimrc.local")
  end
endfunction

set history=50
set incsearch     " do incremental searching
set hlsearch      " highlight search
set laststatus=2  " Always display the status line
set nocompatible  " Use Vim settings, rather then Vi settings
set noswapfile
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set fileencodings=utf-8
set backspace=2

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

call pathogen#infect()
filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:>-,trail:-

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Move using Ctrl + (hjkl)
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Improve syntax highlighting
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.md set filetype=markdown

" Windows options
if has('win32')
  source $VIMRUNTIME\mswin.vim
end

" Local configurations
let s:local = s:LocalRC()
if filereadable(s:local)
  exec "source " . s:local
  let $MY_LOCAL_VIMRC = s:LocalRC()
end
