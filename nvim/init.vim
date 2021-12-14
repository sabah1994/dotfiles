
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'      "Theme
Plug 'preservim/nerdtree'   "file directory
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "to get colour on dev icons
Plug 'tpope/vim-commentary' "to comment easily
Plug 'vim-airline/vim-airline' " Status line
Plug 'tpope/vim-fugitive' " Needed for git branch in vim-airline
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
call plug#end()

" coc extensions
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-pyright',
\ 'coc-snippets',
\ 'coc-tsserver',
\ 'coc-vimlsp',
\ 'coc-pairs'
\ ]

let mapleader = ","

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

"Nerd tree shortcut
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1  " close NERDTree when file open
set splitright            "open vertical split on right
set splitbelow            "open horizental split below
" let g:webdevicons_conceal_nerdtree_brackets=1 " to remove [] from file names in nerd tree, caused by dev icon



set clipboard=unnamedplus          " Copy to system clipboard
set nospell                        " spell check spelunker setting


"Automatically change current directory to crrent file"
set autochdir

"airline config
let g:airline_theme='dark'
" let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#branch#enabled=1


"do not copy delete command
nnoremap d "_d
vnoremap d "_d


source $HOME/.config/nvim/plug-config/coc.vim

" open def in split only if file is not open 
function! SplitIfNotOpen(...)
    let fname = a:1
    let call = ''
    if a:0 == 2
	let fname = a:2
	let call = a:1
    endif
    let bufnum=bufnr(expand(fname))
    let winnum=bufwinnr(bufnum)
    if winnum != -1
	" Jump to existing split
	exe winnum . "wincmd w"
    else
	" Make new split as usual
	exe "vsplit " . fname
    endif
    " Execute the cursor movement command
    exe call
endfunction

command! -nargs=+ CocSplitIfNotOpen :call SplitIfNotOpen(<f-args>)

" Add this to Coc settings
" "coc.preferences.jumpCommand": "CocSplitIfNotOpen"
