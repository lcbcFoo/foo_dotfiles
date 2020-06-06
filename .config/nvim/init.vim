call plug#begin('~/.config/nvim/plugins')

" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': 'yarn install'}

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'pangloss/vim-javascript'
Plug 'heavenshell/vim-jsdoc'
g:jsdoc_lehre_path = '/usr/bin/lehre'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'

"Plug 'vhda/verilog_systemverilog.vim'
Plug 'antoinemadec/vim-verilog-instance'

Plug 'ludovicchabant/vim-gutentags'
set statusline+=%{gutentags#statusline()}
let g:gutentags_project_root = ['tags'] 
let g:gutentags_ctags_extra_args = ['--extra=+q', '--fields=+i', '-n']

" Colorscheme
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim'

"Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git management plugin
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-fubitive'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configs
"
"""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""
" LanguageClient
"""""""""""""""""""""""""""""""""""""""""""""""
let g:LanguageClient_serverCommands = {
    \ 'python': ['/usr/bin/pyls'],
    \ 'javascript': ['/usr/bin/javascript-typescript-stdio'],
    \ 'typescript': ['/usr/bin/javascript-typescript-stdio']
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"""""""""""""""""""""""""""""""""""""""""""""""
" Configs
"""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" Automatically update a file if it is changed externally
set autoread
set ff=unix
" Height of the command bar
"set cmdheight=2

set hlsearch	    " highlight search matches
set incsearch	    " search while characters are entered

" search is case-insensitive by default
set ignorecase

" Show linenumbers
set number

set showcmd	" show last command in the bottom right

set ruler	" always show current position

" Line wrap (number of cols)
set wrap	    " wrap lines only visually
set linebreak	    " wrap only at valid characters
set textwidth=0	    " prevent vim from inserting linebreaks
set wrapmargin=0    "   in newly entered text

set relativenumber  " relative line number

" show matching braces
set showmatch

set wildmenu	    " visual autocomplete for command menu
set wildmode=longest,full

" Begin of line > end of previous line
set ww+=<,>
set whichwrap+=<,>,[,]

" Enable syntax highlighting
syntax on

" UTF-8 encoding and en_US as default encoding/language
set encoding=utf8

" Clear highlight with space
nnoremap <space> :noh<return><esc>

" Buffers
set hidden
set nocompatible

" Keep 3 lines below and above the cursor
set scrolloff=5

"""""""""""""""""""""""""""""""""""""""""""""""""
" Text and Indentation
"""""""""""""""""""""""""""""""""""""""""""""""""
" Use smart tabs
set smarttab

set expandtab " use spaces, no tabs

" 1 tab == 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

set ai " Auto indent
set si " Smart indent

" modern backspace behavior
set backspace=indent,eol,start

filetype indent on	" enable filetype specific indentation
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""
" Persistent Undo
"""""""""""""""""""""""""""""""""""""""""""""""""
set undofile " Maintain undo history between sessions
set undodir=~/.config/nvim/undo " where to save undo histories


"""""""""""""""""""""""""""""""""""""""""""""""""
" Mouse
"""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""
" Movement
"""""""""""""""""""""""""""""""""""""""""""""""""
" move vertically by visual line (don't skip wrapped lines)
nnoremap j gj
nnoremap k gk


"""""""""""""""""""""""""""""""""""""""""""""""""
" Backups, Swap Files
"""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""
" Git
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1 
set updatetime=100

"""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""
"let base16colorspace=256
set termguicolors
" Status bar
let g:airline#extensions#tabX8line#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_base16_improved_contrast = 1
"let g:airline_theme='base16_oceanicnext'

syntax enable

colorscheme dracula
let g:dracula_bold = 1
let g:dracula_italic = 1
let g:dracula_underline = 1
let g:dracula_undercurl = 1
let g:dracula_inverse = 1
let g:dracula_colorterm = 1

highlight Normal         guifg=#c5beba guibg=#363432
highlight Underlined     guibg=bg      guifg=#c4c18b gui=underline
highlight TabLineFill    guibg=bg      guifg=#645d59 gui=NONE
highlight LineNr         guibg=bg      guifg=#a0a0a0 gui=NONE
highlight Pmenu          guibg=bg      guifg=#a8c1c5 gui=NONE
highlight PmenuSbar      guibg=bg      guifg=#363432 gui=NONE
highlight PmenuSel       guibg=#a8c1c5 guifg=#363432 gui=NONE
highlight PmenuThumb     guibg=#9ad1bc guifg=#363432 gui=NONE
highlight WildMenu       guibg=#f0f0f0 guifg=#404040 gui=bold,underline
highlight DiffAdd        guibg=#9ad1bc guifg=#363432 gui=bold
highlight DiffChange     guibg=#c4c18b guifg=#363432 gui=NONE
highlight DiffDelete     guibg=#e7c6be guifg=#645d59 gui=bold
highlight DiffText       guibg=#f0a4af guifg=#363432 gui=bold
" highlight IncSearch      guibg=#f0f0f0 guifg=#342d29 gui=bold
" highlight Search         guibg=#bad4f5 guifg=#363432 gui=italic,bold,underline
highlight MatchParen     guibg=#645d59 guifg=#f0a4af gui=bold
highlight ErrorMsg       guibg=bg      guifg=#be503e gui=bold
highlight ModeMsg        guibg=bg      guifg=#7bb292 gui=NONE
highlight MoreMsg        guibg=bg      guifg=#a8c1c5 gui=bold
highlight Question       guibg=bg      guifg=#c5beba gui=bold
highlight WarningMsg     guibg=bg      guifg=#d7ae38 gui=NONE

