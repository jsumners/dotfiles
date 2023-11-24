" Seup Vim plugin manager
call plug#begin()
  Plug 'pangloss/vim-javascript'
call plug#end()

" Set the title string to the current file being edited
let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
if &term == "screen" || &term == "xterm"
  set title
endif

" Jump to last position from previous edit
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Custom Settings
syntax on
"set cindent " smarter smartindent
set autoindent " basic autoindentation
set expandtab " tabs to spaces
set tabstop=2 " instead of 8
set shiftwidth=2 " instead of 8
set softtabstop=2 " instead of 0
set background=dark " brighter colors for dark terminals
set showcmd " show the current command in the bottom bar
set showmatch " show the matching {([<
set ignorecase " for searching
set hlsearch " highlight searches
set ruler " display line,col in lower right
set scrolloff=3 " show some context at the bottom of the screen
set backspace=indent,eol,start " backspace over everything in insert mode

if exists('+colorcolumn')
  set colorcolumn=80,120
  let s:color_column_old = 0
  function! s:ToggleColorColumn()
    if s:color_column_old == 0
      let s:color_column_old = &colorcolumn
      windo let &colorcolumn = 0
    else
      windo let &colorcolumn = s:color_column_old
      let s:color_column_old = 0
    endif
  endfunction
  " toggle with `\ co`
  nnoremap <Leader>co :call <SID>ToggleColorColumn()<cr>
endif


set number
set numberwidth=3
highlight LineNr ctermfg=grey
" toggle with `\ ln`
nnoremap <Leader>l :set number!<cr>
