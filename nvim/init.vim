" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'      "Theme
Plug 'preservim/nerdtree'   "file directory
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "Correct colour for icons
Plug 'tpope/vim-commentary' "to comment easily
Plug 'vim-airline/vim-airline' " Status line
Plug 'tpope/vim-fugitive' " Needed for git branch in vim-airline
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'PeterRincker/vim-searchlight' " undercursor higlighted text in different colour
Plug 'TaDaa/vimade'                " show inactive windows in different colours
Plug 'lukas-reineke/indent-blankline.nvim' " indent guide
Plug 'airblade/vim-gitgutter' "show git changes on left
Plug 'psliwka/vim-smoothie' "smooth scroll
Plug 'unblevable/quick-scope'
call plug#end()

" Basic configuration
let mapleader = ","
set foldmethod=indent "fold on indent method
set nofoldenable      "do not auto create folds when file opens
set foldnestmax=3     "max nested fold level
set foldlevel=2       "fold level: zr or zm
set encoding=utf-8
set number relativenumber
syntax on
set scrolloff=7       "allow n lines at the bottom
set ignorecase        "ignore case in search
"4 spaces with tab
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamedplus          "copy to system clipboard


"MY KEY MAPPINGS
"do not copy delete command
nnoremap d "_d
vnoremap d "_d
vnoremap p "_dP
"keep jumps and search in middle
nmap n nzz
nmap N Nzz
nmap <C-o> <C-o>zz
nmap <C-i> <C-i>zz
"get rid of trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
"copy whole buffer
nnoremap <F5> :%y+<CR>
"Escape: also clears highlighting
nnoremap <silent> <esc> <Cmd>noh<return><esc>

"PLUGINS configuration
let g:python3_host_prog="~/vim_venv/bin/python"

"coc.vim
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-pyright',
\ 'coc-java',
\ 'coc-snippets',
\ 'coc-tsserver',
\ 'coc-vimlsp',
\ 'coc-pairs',
\ 'coc-lists',
\ 'coc-sh'
\ ]
" open coc-defitin in vsplit
nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit') <CR>

"gruvbox | statusline
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

"vim-airline | statusline
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1 "Enable the list of buffers top
let g:airline#extensions#branch#enabled=1

"nerdtree
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1  " close NERDTree when file open
set splitright            "open vertical split on right
set splitbelow            "open horizental split below
let NERDTreeWinSize = 50  "NT win size
let NERDTreeShowHidden=1  "show hidden files
let NERDTreeIgnore=['\.git$']   "ignore git folder

"vim-gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

"quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']


source $HOME/.config/nvim/plug-config/coc.vim

