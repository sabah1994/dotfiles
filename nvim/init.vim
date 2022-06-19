" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'              "Theme
Plug 'preservim/nerdtree'           "File directory
Plug 'ryanoasis/vim-devicons'       "File icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      "Correct colour for icons
Plug 'tpope/vim-commentary'         "Comment easily
Plug 'vim-airline/vim-airline'      "Status line
Plug 'bling/vim-bufferline'         "Buffers in statusline
Plug 'tpope/vim-fugitive'           "Needed for git branch in vim-airline
Plug 'neoclide/coc.nvim', {'branch': 'release'}     "Conquer of Completion
Plug 'honza/vim-snippets'           "Snippets
Plug 'PeterRincker/vim-searchlight' "Undercursor higlighted text in different colour
Plug 'TaDaa/vimade'                 "Show inactive windows in different colours
Plug 'lukas-reineke/indent-blankline.nvim'          "Indent guide
Plug 'airblade/vim-gitgutter'       "Show git changes on left
Plug 'psliwka/vim-smoothie'         "Smooth scroll
Plug 'unblevable/quick-scope'       "Highlights chars in current line to move easily
Plug 'phaazon/hop.nvim'             "Easy hop around
Plug 'tpope/vim-surround'           "Easy text-object sorrounding plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}      "Syntax tree plugin
call plug#end()

"true colours for nvim in tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Basic configuration
let mapleader = ","
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
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
"in V Line mode, don't delete line break if text in register doesn't have line
"break. DON'T stupidly join pasted text to below line
vnoremap <expr> p mode() ==# "V" && match(getreg(), "\n$") == -1 ? "\"_dd<esc>O<esc>p" : "\"_dP"
"paste text on new line, if there is already linebreak do not insert a new one
nnoremap <expr> <leader>p  match(getreg(), "\n$") == -1 ? "o<esc>p" : "p"
nnoremap <expr> <leader>P  match(getreg(), "\n$") == -1 ? "O<esc>p" : "P"
"move at the start and end of line easily
noremap H ^
noremap L $
" buffers shortcuts
nnoremap <leader>n :bn<CR>
nnoremap <leader>b :bp<CR>
nnoremap <leader>d :bd<CR>
" move code alt+arrows
nnoremap <silent> <M-Up>    :<C-U>exec "exec 'norm m`' \| move -" . (1+v:count1)<CR>``
nnoremap <silent> <M-Down>  :<C-U>exec "exec 'norm m`' \| move +" . (0+v:count1)<CR>``
inoremap <silent> <M-Up>    <C-O>m`<C-O>:move -2<CR><C-O>``
inoremap <silent> <M-Down>  <C-O>m`<C-O>:move +1<CR><C-O>``
vnoremap <silent> <M-Up>    :<C-U>exec "'<,'>move '<-" . (1+v:count1)<CR>gv
vnoremap <silent> <M-Down>  :<C-U>exec "'<,'>move '>+" . (0+v:count1)<CR>gv
"keep jumps and search in middle
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
"get rid of trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
"copy whole buffer
nnoremap <F5> :%y+<CR>
"Escape: also clears highlighting
nnoremap <silent> <esc> <Cmd>noh<return><esc>

" Text objects
" inner line
xnoremap il ^og_

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

"gruvbox | statusline
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

"vim-airline | statusline
let g:airline_theme='dark'
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts = 1

" vim-bufferline
let g:bufferline_echo = 0  "do not echo to command line
"To keep active buffer at the first position
" let g:bufferline_rotate = 1
" let g:bufferline_fixed_index =  0 "always first

"nerdtree
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1  " close NERDTree when file open
set splitright            "open vertical split on right
set splitbelow            "open horizental split below
let NERDTreeWinSize = 50  "NT win size
let NERDTreeShowHidden=1  "show hidden files
let NERDTreeIgnore=['\.git$', 'venv$', '__pycache__$']   "ignore git folder

"vim-fugitive
noremap <leader>gv :Gvdiffsplit<CR>
" git checkout --filename at buffer level (use undo to revert checkout)
noremap <leader>gc :Gread<CR>
"Git add --filename
noremap <leader>ga :Gwrite<CR>
noremap <leader>gd :G diff<CR>
noremap <leader>gds :G diff --staged<CR>
" Notes: useful commands
" Git blame       - Open git blame on left, press o open the commit
" Git difftool    - Open diff for current buffer in quickfix list
" Git difftool -y - Open all git modifed files in a new tab
" Gclog           - Open commit history in quick fix list (use cn and cp to
" jump between quickfix items)

"vim-gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
"text-objects
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

"quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#00dfff' gui=bold,underline ctermfg=45 cterm=bold,underline
highlight QuickScopeSecondary guifg='#afff5f' gui=bold,underline ctermfg=155 cterm=bold,underline

" hop.vim
lua << EOF
require'hop'.setup()
EOF
"Not mapping s in operator mode because it's taken by surround
nmap s <cmd>HopChar2<CR>
vmap s <cmd>HopChar2<CR>
map <leader>l <cmd>HopLine<CR>
map <leader>w <cmd>HopWord<CR>

source $HOME/.config/nvim/plug-config/tree-sitter.vim
source $HOME/.config/nvim/plug-config/coc.vim

