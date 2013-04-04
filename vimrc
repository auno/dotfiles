" vim: set ts=4 sw=4 expandtab:

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
filetype off                    " force reloading *after* pathogen loaded
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on       " enable detection, plugins and indenting in one step

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

set nocompatible        " Use Vim defaults (much better!)
set bs=2                " allow backspacing over everything in insert mode
set ai                  " always set autoindenting on
"set backup             " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=1000        " keep 1000 lines of command line history
set undolevels=1000     " keep 1000 levels of undo history
set ruler               " show the cursor position all the time
set linebreak           " don't linebreak words
set nowrap              " don't wrap lines at all
set laststatus=2        " always show the status line
set ts=4                " a tab-character should be represented as 4 spaces
set sw=4                " indent is 4 spaces
set expandtab           " insert spaces instead of tabs
set sta                 " enable smart tab handling 
set showmatch           " show matching parenthesis etc
set number              " show line numbers
set incsearch           " incremental search
set scrolloff=8         " have cursor 8 lines from top or bottom when scrollnig
set wildmenu            " show menu when tab completing commands
set shiftround          " round indent (using > and <) to multiple of 'shiftwidth'
set wildignore=*.o,*.obj,*.class,.git,.svn
set ww=<,>,[,],b,s

" Only do this part when compiled with support for autocommands
if has("autocmd")
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal g'\"" |
    \ endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Set colorscheme
if &t_Co >= 256
    colorscheme mustang
    set cursorline
else
    colorscheme desert
endif
" Reset SignColumn in case colorscheme changed it
highlight clear SignColumn

" Configure tags
set tags=./tags;/
map <A-]> :vsp <CR>:wincmd w<CR>:exec("tag ".expand("<cword>"))<CR>

" Add file format information to status line
set statusline=%<%f\ %h%m%r%=%{\"[\".&fileformat.\",\ \".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-13.(%l,%c%V%)\ %P
" Prevent the Perforce plugin to mess with the statusbar
let g:p4EnableActiveStatus = 0

" localvimrc should not ask before loading a .lvimrc
let g:localvimrc_ask = 0

" allow 30000 files for command-t
let g:CommandTMaxFiles = 30000

" tell ack where to find the ack command
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" change the mapleader from \ to ,
let mapleader=","

nmap <silent> <leader>/ :nohlsearch<CR> " hide current search matches
nmap <leader>u :GundoToggle<CR>         " toggle gundo window
nmap <A-Left> <C-O>                     " jump back
nmap <A-Right> <C-I>                    " jump forward
