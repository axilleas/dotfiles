"vim: set sw=4 ft=vim :
"-----------------------------------------------
" Script:    $HOME/.vimrc
" Author:    Uwe <keksvernichter AT gmail DOT com>
"-----------------------------------------------

"----------------------------------------------
" plugins/colorschemes used
"----------------------------------------------
"
" secure modelines:      http://github.com/ciaranm/securemodelines
" candycode colorscheme: http://www.vim.org/scripts/script.php?script_id=1635
" calendar:              http://www.vim.org/scripts/script.php?script_id=52
" cmdline complete:      http://www.vim.org/scripts/script.php?script_id=2222
" comments:              http://www.vim.org/scripts/script.php?script_id=1528
" uptime:                http://www.vim.org/scripts/script.php?script_id=965
"
scriptencoding utf-8
set encoding=utf-8

set nocompatible   " disable vi compatibility
"autocmd vimenter * NERDTree

" Enable pathogen
execute pathogen#infect()

"-----------------------------------------------
" modelines (secure modelines plugin req.)
"-----------------------------------------------
" disable internal modelines parser
set modelines=0
let g:secure_modelines_verbose=0       " securemodelines vimscript
let g:secure_modelines_modelines = 15  " 15 available modelines

let mapleader = "," " <leader> is ,

"-----------------------------------------------
" general settings
"-----------------------------------------------
filetype plugin indent on " start file type plugin and indentation
set hidden          " hides buffers instead of closing them
"set nowrap          " don't wrap lines
set backspace=indent,eol,start
                    " allow backspacing over everything in insert mode
set shiftwidth=2    " number of spaces to indent
set tabstop=2       " number of spaces <TAB> counts for
set expandtab       " insert space characters whenever the tab key is pressed
set textwidth=0     " disable automatic word-wrapping
set number          " show line numbers
set incsearch       " incremental searching
set ignorecase      " search ignoring case
set hlsearch        " highlight searches
set showmatch       " show matching brackets
set showmode        " show current mode
set ruler           " show position of cursor
set title           " show title in console status bar
set autoindent      " don't autoindent code
set nosmartindent
set cmdheight=1     " commandbar height
set linebreak       " break line at word
set nostartofline   " remember the cursor position
set scrolloff=10    " keep 10 lines for scope
set pastetoggle=<F2> "paste mode
set colorcolumn=80  " set marker
"set mouse=a


"------------------------------
" Theme
"------------------------------
"set t_Co=256
set background=dark
colorscheme molokai
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
let g:molokai_original = 1

"------------------------------
" lightline
"------------------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }


function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "RO"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction


"-----------------------------------------------
" markdown settings
"-----------------------------------------------
let g:vim_markdown_folding_disabled=1 " disable folding

"-----------------------------------------------
" CtrlP plugin
"-----------------------------------------------
set runtimepath^=~/.vim/bundle/ctrlp.vim

"-----------------------------------------------
" ctags
"-----------------------------------------------
" search for a tags file in current dir
set tags=./tags;

"-----------------------------------------------
" syntax-highlighting
"-----------------------------------------------
" enable syntax-highlighting
if has ("syntax")
	syntax on
endif

"-----------------------------------------------
" backup
"-----------------------------------------------
" create a backup file in the backup directory
set backup
set backupdir=~/.backup
set history=2000

"-----------------------------------------------
" statusline
"-----------------------------------------------
" always show status line
set laststatus=2

" format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '$HOME', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


"-----------------------------------------------
" misc. commands
"-----------------------------------------------

" turn off any existing searches
if has ("autocmd")
	au VimEnter * nohls
endif

"-----------------------------------------------
" Mappings
"-----------------------------------------------
map <C-n> :NERDTreeToggle<CR>
imap <C-d> <esc>ddi
nnoremap <F5> :GundoToggle<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
inoremap kj <esc>l
nnoremap nh <esc>:noh<CR>
vnoremap <leader>y "+y<CR>
vnoremap <leader>p "+p<CR>
