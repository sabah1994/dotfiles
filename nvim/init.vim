
" let g:python3_host_prog = '/usr/local/opt/python@3.7/bin/python3'

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'      "Theme
Plug 'preservim/nerdtree'   "file directory
Plug 'dense-analysis/ale'   "for linter and fixers. pip [flake8, black]
Plug 'davidhalter/jedi-vim' "Python autocompleter, pip [jedi]
Plug 'tpope/vim-commentary' "to comment easily
Plug 'ryanoasis/vim-devicons' " icons on files in NT
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "to get colour on dev icons
Plug 'vim-airline/vim-airline' " Status line
Plug 'tpope/vim-fugitive' " Needed for git branch in vim-airline
call plug#end()

let mapleader = ","

colorscheme gruvbox
set background=dark
set encoding=utf-8
set number relativenumber
" syntax on                       "Adds brackets around files in NT
set scrolloff=7                 "Allow n lines at the bottom
set ignorecase                  "ignore case in search

"4 spaces with tab
set tabstop=4
set shiftwidth=4
set expandtab

"Nerd tree shortcut
:command NT NERDTreeToggle
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1  " close NERDTree when file open
set splitright            "open vertical split on right
set splitbelow            "open horizental split below
" let g:webdevicons_conceal_nerdtree_brackets=1 " to remove [] from file names in nerd tree, caused by dev icon

"auto completion
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

set clipboard=unnamedplus          " Copy to system clipboard
set nospell                        " spell check spelunker setting

"Automatically change current directory to crrent file"
set autochdir

"jedi vim"
let g:jedi#use_splits_not_buffers = "right"
"let g:jedi#use_tabs_not_buffers = 1 "open tab instead of split of buffer

"ALE plugin
"flake8
let g:ale_linters = {'python':['flake8']}
" let g:ale_linters = {'python':[]}
let g:ale_fixers = {'*': ['remove_trailing_lines','trim_whitespace'],'python':['black'],}
let g:ale_fix_on_save = 1                   "fix on save
"let g:ale_lint_on_text_changed = 0          "Don't linter on text change
"key mappings:
"test this mapping
"map <silent> <C-d> :ALEGoToDefinition<CR>
"To test what global variabels are set :ALEInfo

"airline config
let g:airline_theme='dark'
" let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#branch#enabled=1


"Black
"Auto format python files with black
"autocmd BufWritePre *.py execute ':Black'

" copy fulll file path
" :nmap cp :let @" = expand("%:p")<cr>

"do not copy delete command
nnoremap d "_d
vnoremap d "_d
