""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Vundler for plugin management
""""""""""""""""""""""""""""""""""""""""""""""""



set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" NERD tree - tree explorer
Plugin 'scrooloose/nerdtree'

" Base16 colorschemes
Plugin 'chriskempson/base16-vim'

" Ctrl-p
Plugin 'kien/ctrlp.vim'

" Elixir syntax highlighting
Plugin 'vim-syntastic/syntastic'

" Vimwiki
Plugin 'vimwiki/vimwiki'

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" AutoClose
Plugin 'jiangmiao/auto-pairs'

" Status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Theme
Plugin 'arcticicestudio/nord-vim'

" Git
Plugin 'tpope/vim-fugitive' 
Plugin 'airblade/vim-gitgutter'

" Commentary
Plugin 'tpope/vim-commentary'

" Ident Line
Plugin 'Yggdroot/indentLine'

" Keep Plugin commands between vundle#begin/end.

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","       " leader is comma

" turn off search highlight with ,-<space>
" nnoremap <leader><space> :nohlsearch<CR>

" Invoke Ctrl-p with c-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


""""""""""""""""""""""""""""""""""""""""""""""""
" General Configuration
""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically update a file if it is changed externally
set autoread

" Height of the command bar
set cmdheight=2

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


" show matching braces
set showmatch

set wildmenu	    " visual autocomplete for command menu

" Begin of line > end of previous line 
set ww+=<,>
set whichwrap+=<,>,[,]


" Open on line that closed
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" Clear highlight with space
nnoremap <space> :noh<return><esc>

"""""""""""""""""""""""""""""""""""""""""""""""""
" YCM conf
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '$HOME/.ycm_extra_conf.py'


"""""""""""""""""""""""""""""""""""""""""""""""""
" Backups, Swap Files
"""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

" UTF-8 encoding and en_US as default encoding/language
set encoding=utf8

" Define standard filetype
set ffs=unix,dos,mac

let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-tomorrow-night

" Visual Mode 
highlight Visual ctermfg=0 ctermbg=250 

" Menu colors
highlight Pmenu ctermfg=238 ctermbg=253
" Menu selelected
highlight PmenuSel ctermfg=230 ctermbg=243

" Error
highlight Search ctermfg=0 ctermbg=250

" Pairs highlight
highlight MatchParen cterm=bold ctermfg=255 ctermbg=0

" Selected tab (files)
highlight TabLineSel ctermfg=0 ctermbg=255

" Wild menu (command 'tab' suggestions)
highlight WildMenu ctermfg=0 ctermbg=250

" Bad Spell
highlight clear SpellBad
highlight clear SpellCap
highlight clear SpellRare
highlight clear SpellLocal

highlight SpellBad cterm=underline ctermfg=196 ctermbg=0
highlight SpellCap cterm=underline ctermfg=190 ctermbg=0
highlight SpellRare cterm=underline 
highlight SpellLocal cterm=underline


set cursorline	" highlight current active line
highlight CursorLine ctermbg=235

"""""""""""""""""""""""""""""""""""""""""""""""""
" Persistent Undo
"""""""""""""""""""""""""""""""""""""""""""""""""
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undo " where to save undo histories

"""""""""""""""""""""""""""""""""""""""""""""""""
" Git
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1 
set updatetime=100

"""""""""""""""""""""""""""""""""""""""""""""""""
" File Types
"""""""""""""""""""""""""""""""""""""""""""""""""
" recognize .md files as markdown files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" enable spell-checking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

"""""""""""""""""""""""""""""""""""""""""""""""""
" Text and Indentation
"""""""""""""""""""""""""""""""""""""""""""""""""
" Use smart tabs
set smarttab

set expandtab " use spaces, no tabs

" 1 tab == 4 spaces
set shiftwidth=4
set softtabstop=4

set ai " Auto indent
set si " Smart indent

" modern backspace behavior
set backspace=indent,eol,start

filetype indent on	" enable filetype specific indentation

"""""""""""""""""""""""""""""""""""""""""""""""""
" Mouse
"""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a
set ttymouse=xterm

"""""""""""""""""""""""""""""""""""""""""""""""""
" Movement
"""""""""""""""""""""""""""""""""""""""""""""""""
" move vertically by visual line (don't skip wrapped lines) 
nnoremap j gj
nnoremap k gk

"""""""""""""""""""""""""""""""""""""""""""""""""
" Status bar
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabX8line#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_base16_improved_contrast = 1
let g:airline_theme='base16_oceanicnext'

"""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl-p
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'ra'


"""""""""""""""""""""""""""""""""""""""""""""""""
" vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""
" automatically generate HTML files
let g:vimwiki_list = [{'path': '~/vimwiki/', 'auto_export': 1}]

