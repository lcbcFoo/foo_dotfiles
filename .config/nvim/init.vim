
call plug#begin('~/.config/nvim/plugins')

" File explorer
"Plug 'francoiscabrol/ranger.vim'
"Plug 'rbgrouleff/bclose.vim'

" Auto complete
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'zchee/deoplete-jedi'

" Utils
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'blindFS/vim-taskwarrior'
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine'
Plug 'chriskempson/base16-vim'
Plug 'jacoborus/tender.vim'
Plug 'ctrlpvim/ctrlp.vim'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git management plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntatstic
"Plug 'vim-syntastic/syntastic'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""
" Configs
"""""""""""""""""""""""""""""""""""""""""""""""
" Automatically update a file if it is changed externally
set autoread

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


" show matching braces
set showmatch

set wildmenu	    " visual autocomplete for command menu

" Begin of line > end of previous line
set ww+=<,>
set whichwrap+=<,>,[,]

" Enable syntax highlighting
syntax on

" UTF-8 encoding and en_US as default encoding/language
set encoding=utf8

" Open on line that closed
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" Clear highlight with space
nnoremap <space> :noh<return><esc>

" Ctrl P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"nnoremap <c-p> :RangerCurrentDirectory<CR>

" Buffers
set hidden

" Tab navigation
nnoremap <C-left> :tabprevious<CR>
nnoremap <C-right>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-left> <Esc>:tabprevious<CR>i
inoremap <C-right>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
" YCM conf
"""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ycm_global_ycm_extra_conf = '$HOME/.ycm_extra_conf.py'


"""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1



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
let g:airline_theme='base16_oceanicnext'

"colorscheme base16-phd


syntax enable
colorscheme tender
let g:lightline = { 'colorscheme': 'tenderplus' }

" Visual Mode 
"highlight Visual ctermfg=0 ctermbg=250 

"" Menu Selected
"highlight PmenuSel ctermfg=238 ctermbg=253
"" Menu 
"highlight Pmenu ctermfg=230 ctermbg=243

"" Error
"highlight Search ctermfg=0 ctermbg=250

"" Pairs highlight
"highlight MatchParen cterm=bold ctermfg=255 ctermbg=240

"" Selected tab (files)
"highlight TabLineSel ctermfg=0 ctermbg=255

"" Wild menu (command 'tab' suggestions)
"highlight WildMenu ctermfg=0 ctermbg=250

"" Numbers
highlight LineNr guifg=#606060
""ctermbg=255

"" Bad Spell
"highlight clear SpellBad
"highlight clear SpellCap
"highlight clear SpellRare
"highlight clear SpellLocal

"highlight SpellBad cterm=underline ctermfg=196 ctermbg=0
"highlight SpellCap cterm=underline ctermfg=190 ctermbg=0
"highlight SpellRare cterm=underline 
"highlight SpellLocal cterm=underline


"set cursorline	" highlight current active line
"highlight CursorLine guibg=#152039
