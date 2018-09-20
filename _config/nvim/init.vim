set nocompatible
filetype off
let mapleader=","

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/TaskList.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'altercation/vim-colors-solarized'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

" Initialize plugin system
call plug#end()

filetype plugin indent on    " required

" Toggle TaskList
map <leader>td <Plug>TaskList

" Toggle Tagbar
map <leader>tb :TagbarToggle<CR>

" Open and close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

" Setup NerdTree shortcuts
map <leader>N :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>

" Setup FZF
map <leader>f :Files<CR>
map <leader>a :Lines<CR>
map <leader>b :Buffers<CR>

" Load the Gundo window
map <leader>gu :GundoToggle<CR>

" Paste from clipboard
map <leader>p "+p

" Yank to clipboard
set clipboard=unnamed

" Hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<CR>

" Ultisnips trigger configuration
let g:UltiSnipsExpandTrigger="<D-e>"
let g:UltiSnipsJumpForwardTrigger="<D-r>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" Configure YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" Go
" ==

" vim-go bin path
let g:go_bin_path=expand("~/Developer/go/bin")

" Use goimports
let g:go_fmt_command = "goimports"

" Go compilation shortcuts
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)

" Godoc mappings
au FileType go nmap <leader>gd <Plug>(go-doc)

" Go definition mappings
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <leader>d <Plug>(go-def-split)
au FileType go nmap <leader>v <Plug>(go-def-vertical)

" Type information
au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap <leader>s <Plug>(go-implements)

" Rename
au FileType go nmap <leader>e <Plug>(go-rename)

" Open Tagbar on launch
au FileType go TagbarOpen

" Vim
" ===

" Basic settings
syntax enable               " Syntax highlighing
filetype on                 " Detect filetypes
filetype plugin indent on   " Enable loading indent file for filetype
set timeoutlen=250          " Life is short, why wait 1000
set number                  " Display line numbers
set numberwidth=2           " Set gutter width
set background=dark         " Use dark theme
set title                   " Show title in console title bar
set wildmenu                " Menu completion in command mode on <Tab>
set wildmode=full           " <Tab> cycles between all matching choices.

" Ignore these files when completing
set wildignore+=.git

" Moving around and editing
set cursorline              " Have a line indicate the cursor location
set ruler                   " Show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set linebreak               " Don't wrap text in the middle of a word
set autoindent              " Always set autoindenting on
set smartindent             " Use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " But an indent level is 2 spaces wide
set softtabstop=4           " <BS> over an autoindent deletes both spaces
set shiftround              " Rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " Show matching <> (html mainly) as well
set foldlevel=99            " Don't fold by default

" Reading and writing
set noautowrite             " Never write a file unless I request it
set noautowriteall          " NEVER
set autoread                " Load changed files automatically
set modeline                " Allow vim options to be embedded in files
set modelines=5             " They must be within the first or last 5 lines
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings

" Messages, info, status
set noerrorbells            " NO error bells
set vb t_vb=                " Disable all bells
set ls=2                    " Allways show status line
set confirm                 " Y-N-C prompt if closing with unsaved changes
set showcmd                 " Show incomplete normal mode commands as I type
set report=0                " : commands always print changed line count
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written
set ruler                   " Show some info, even without statuslines
set laststatus=2            " Always show statusline, even if only 1 window
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

" Displays tabs with :set list & displays when a line runs off-screen
" Set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
set listchars=tab:\ \ ,trail:-,precedes:<,extends:>
set list

" Searching and patterns
set ignorecase              " Default to using case insensitive searches
set smartcase               " unless uppercase letters are used in the regex
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default
set incsearch               " Incrementally search while typing a /regex

" Solarized options
silent! colorscheme solarized
