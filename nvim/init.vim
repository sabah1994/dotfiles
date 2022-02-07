
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'      "Theme
Plug 'preservim/nerdtree'   "file directory
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary' "to comment easily
Plug 'vim-airline/vim-airline' " Status line
Plug 'tpope/vim-fugitive' " Needed for git branch in vim-airline
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'PeterRincker/vim-searchlight' " undercursor higlighted text in different colour
Plug 'TaDaa/vimade'                " show inactive windows in different colours
call plug#end()


let g:python3_host_prog="/home/sabah/Desktop/vim_venv/bin/python"
" coc extensions
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-pyright',
\ 'coc-java',
\ 'coc-snippets',
\ 'coc-tsserver',
\ 'coc-vimlsp',
\ 'coc-pairs',
\ 'coc-lists'
\ ]
let mapleader = ","
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set encoding=utf-8
set number relativenumber
syntax on                       "
set scrolloff=7                 "Allow n lines at the bottom
set ignorecase                  "ignore case in search
"4 spaces with tab
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamedplus          " Copy to system clipboard
set nospell                        " spell check spelunker setting
" set autochdir "Automatically change current directory to crrent file"

"airline config
let g:airline_theme='dark'
" let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#branch#enabled=1

"Nerd tree shortcut
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1  " close NERDTree when file open
set splitright            "open vertical split on right
set splitbelow            "open horizental split below
let NERDTreeWinSize = 50   " NT win size

"do not copy delete command
nnoremap d "_d
vnoremap d "_d
vnoremap p "_dP

" open coc-defitin in vsplit
nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit') <CR>

source $HOME/.config/nvim/plug-config/coc.vim

