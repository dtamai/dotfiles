set nocompatible  " Use Vim settings, rather then Vi settings
set history=1000
set incsearch     " do incremental searching
set hlsearch      " highlight search
set laststatus=2  " Always display the status line
set noswapfile
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set fileencodings=utf-8
set backspace=2   " backspace over everything
set wildmenu
set ignorecase
set smartcase
set showmatch    " blink matching pairs {[(
set cursorline
set winwidth=87
set winheight=30

"set autochdir
" Don't use Ex mode, use Q for formatting
map Q gq

" Change leader
let mapleader=" "

" Map <leader>e to open files in the same directory as the current file
nnoremap <leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" Run rspec spec under cursor
nnoremap <C-t> :wa<CR> \| :!rspec %:<C-r>=line('.')<CR><CR>

nnoremap <F5> :nohlsearch<CR>

" Swap v and CTRL-V, Visual and Visual Block
nnoremap v <C-v>
nnoremap <C-v> v

vnoremap v <C-v>
vnoremap <C-v> v

" cd into current file dir
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

nnoremap <leader>\ :echo strftime("%c")<CR>
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  let &t_Co=256
endif

call pathogen#infect()
filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list
set listchars=tab:>\ ,trail:·,extends:>,precedes:<,nbsp:+

" Numbers
set relativenumber
set numberwidth=5

" Pretty status line
set statusline=%<%f\ %y[%n]%=\ %(%1*%m%r%h%)%*\ L%l,C%c\ %P

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Autocomplete using <C-x><C-u> (INSERT)
set completefunc=syntaxcomplete#Complete

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
au BufRead,BufNewFile *.xml set noexpandtab

" Some colors
set t_Co=256
colorscheme molokai
hi User1 ctermbg=Red ctermfg=Yellow gui=bold guibg=Red guifg=Yellow

" Identify long lines
hi ColorColumn ctermbg=lightgreen ctermfg=black
call matchadd('ColorColumn', '\%81v', 100)

" Windows options
if has('win32')
  source $VIMRUNTIME\mswin.vim
end

" Copy Clipboard
if has('win32unix')
  vnoremap <leader>y :w ! cat > /dev/clipboard<CR><CR>
else
  vnoremap <leader>y :<Esc>`>a<CR><Esc>mx`<i<CR><Esc>my'xk$v'y!xclip -selection c<CR>u
end

" RainbowParentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['gray',        'DarkOrchid3'],
    \ ['177',         'RoyalBlue3'],
    \ ['darkmagenta', 'RoyalBlue3'],
    \ ['lightblue',   'SeaGreen3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['yellow',      'firebrick3'],
    \ ['214',         'firebrick3'],
    \ ['red',         'DarkOrchid3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['177',         'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['lightblue',   'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['yellow',      'DarkOrchid3'],
    \ ['214',         'SeaGreen3'],
    \ ['red',         'firebrick3'],
    \ ]

