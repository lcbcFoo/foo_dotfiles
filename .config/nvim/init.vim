lua require('plugins')


call plug#begin('~/.config/nvim/plugins')

Plug 'ctrlpvim/ctrlp.vim'

""""
" Doge documentation
Plug 'kkoomen/vim-doge'

" Code format
Plug 'sbdchd/neoformat'
let g:neoformat_c_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['-style=file'],
    \ }

"""""""""""""""""""""""""""""""""""""""""""""""""
" Language Server
"""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neovim/nvim-lspconfig'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

"""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'lervag/vimtex'

Plug 'blindFS/vim-taskwarrior'

" File tree explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = expand('~/Documents/markdown_style.css')


Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'

"Plug 'vhda/verilog_systemverilog.vim'
"Plug 'antoinemadec/vim-verilog-instance'

" Plug 'ludovicchabant/vim-gutentags'
" set statusline+=%{gutentags#statusline()}
" let g:gutentags_project_root = ['tags'] 
" let g:gutentags_ctags_extra_args = ['--extra=+q', '--fields=+i', '-n']

" Colorscheme
Plug 'dracula/vim'

""""""""""""""""""""""""""""""""""""""
" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 0


"""""""""""""""""""""""""""""""""""""
" git management plugin
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-fubitive'

call plug#end()

" Set mapping before other mappings
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configs
"
"""""""""""""""""""""""""""""""""""""""""""""""

" Tabline
"
" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent>b] :BufferLineCyclePrev<CR>

" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent><mymap> :BufferLineMoveNext<CR>
nnoremap <silent><mymap> :BufferLineMovePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>
nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>

set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

"""""""""""""""""""""""""""""""""""""""""""""""
" Configs
"""""""""""""""""""""""""""""""""""""""""""""""

" Automatically update a file if it is changed externally
set autoread
set ff=unix
" Height of the command bar
"set cmdheight=2

" Clipboard
" set clipboard+=unnamedplus

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

