call plug#begin('~/.config/nvim/plugins')

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Shougo crazy stuff
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do' : ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'

"Plug 'vhda/verilog_systemverilog.vim'
" Plug 'antoinemadec/vim-verilog-instance'


" Plug 'rhysd/vim-clang-format'
"Plug 'ludovicchabant/vim-gutentags'
"set statusline+=%{gutentags#statusline()}
"let g:gutentags_project_root = ['tags'] 
"let g:gutentags_ctags_extra_args = ['--extra=+q', '--fields=+i', '-n']

" Colorscheme
Plug 'chriskempson/base16-vim'
Plug 'jacoborus/tender.vim'

"Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git management plugin
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configs
"
"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""
" Denite
"""""""""""""""""""""""""""""""""""""""""""""""
call denite#custom#map('insert', '<Down>', 
            \ '<denite:move_to_next_line>', 'noremap')

call denite#custom#map('insert', '<Up>',
            \ '<denite:move_to_previous_line>', 'noremap')

"""""""""""""""""""""""""""""""""""""""""""""""
" CCLS for C/C++/CUDA/OBJC
"""""""""""""""""""""""""""""""""""""""""""""""
let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls', '--log-file=/tmp/cc.log',
    	\ '--init={"cacheDirectory":"/tmp/ccls/"}'],
    \ 'cpp': ['ccls', '--log-file=/tmp/cc.log',
    	\ '--init={"cacheDirectory":"/tmp/ccls/"}'],
    \ 'cuda': ['ccls', '--log-file=/tmp/cc.log',
    	\ '--init={"cacheDirectory":"/tmp/ccls/"}'],
    \ 'objc': ['ccls', '--log-file=/tmp/cc.log',
    	\ '--init={"cacheDirectory":"/tmp/ccls/"}'],
    \ }


"""""""""""""""""""""""""""""""""""""""""""""""
" Neosnips
"""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
     \ "\<Plug>(neosnippet_expand_or_jump)"
     \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
     \ "\<Plug>(neosnippet_expand_or_jump)"
     \: "\<TAB>"

"""""""""""""""""""""""""""""""""""""""""""""""
" Cquery
"""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR><Paste>

"""""""""""""""""""""""""""""""""""""""""""""""
" Configs
"""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

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
let g:airline_theme='base16_oceanicnext'


syntax enable
colorscheme tender

" Visual Mode 
highlight Visual guifg=#483D8B guibg=#B0C4DE 

" Menu Selected
highlight PmenuSel guifg=#B0C4DE guibg=#483D8B

" Menu 
highlight Pmenu guifg=#483D8B guibg=#B0C4DE

" Pairs highlight
highlight MatchParen gui=bold guifg=#FFFFFF

" Wild menu (command 'tab' suggestions)
highlight WildMenu guifg=#202020 guibg=#EEEEEE

" Numbers
highlight LineNr guifg=#a0a0a0

set cursorline	" highlight current active line
highlight CursorLine guibg=#303030

