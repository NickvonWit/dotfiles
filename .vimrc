" Enable relative line numbers
set relativenumber

" Enable absolute line number for the current line
set number

" Enable syntax highlighting
syntax enable

" Enable auto-indentation
set autoindent
set smartindent

" Enable search highlighting as you type
set incsearch

" Use case-insensitive search
set ignorecase
set smartcase

" Set the tab width to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Enable line wrapping
set wrap

" Show matching parentheses/brackets
set showmatch

" Enable line and column number in the status line
set ruler

" Syntax highlighting for specific file types
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4

" Enable auto-pairing of brackets, quotes, etc.
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

" Enable path completion with <Tab>
set wildmenu
set wildmode=list:longest

" Enable clipboard support
set clipboard=unnamedplus

" Enable a list of file types for which automatic indentation is used
filetype plugin indent on

" Enable line numbers for specific file types
autocmd FileType c,cpp,python,s set number

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/


