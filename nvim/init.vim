" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'              "Theme
" Plug 'tanvirtin/monokai.nvim'     "TODO: make this work (like bat theme)
Plug 'preservim/nerdtree'           "File directory
Plug 'sheerun/vim-polyglot'         "Syntax highlight
Plug 'ryanoasis/vim-devicons'       "File icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      "Correct colour for icons
Plug 'tpope/vim-commentary'         "Comment easily
Plug 'vim-airline/vim-airline'      "Status line
Plug 'tpope/vim-fugitive'           "Needed for git branch in vim-airline
Plug 'neoclide/coc.nvim', {'branch': 'release'}     "Conquer of Completion
Plug 'honza/vim-snippets'           "Snippets
Plug 'PeterRincker/vim-searchlight' "Undercursor higlighted text in different colour
Plug 'TaDaa/vimade'                 "Show inactive windows in different colours
Plug 'lukas-reineke/indent-blankline.nvim'          "Indent guide
Plug 'airblade/vim-gitgutter'       "Show git changes on left
Plug 'psliwka/vim-smoothie'         "Smooth scroll
Plug 'unblevable/quick-scope'       "Highlights chars in current line to move easily
Plug 'justinmk/vim-sneak'           "Easy motions vertically
Plug 'tpope/vim-surround'           "Easy text-object sorrounding plugin
call plug#end()

"true colours for nvim in tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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
"in V Line mode, don't delete line break if text in register doesn't have line
"break. DON'T stupidly join pasted text to below line
vnoremap <expr> p mode() ==# "V" && match(getreg(), "\n$") == -1 ? "\"_dd<esc>O<esc>p" : "\"_dP"
"paste text on new line, if there is already linebreak do not insert a new one
nnoremap <expr> <leader>p  match(getreg(), "\n$") == -1 ? "o<esc>p" : "p"
nnoremap <expr> <leader>P  match(getreg(), "\n$") == -1 ? "O<esc>p" : "P"
"move at the start and end of line easily
noremap H ^
noremap L $
" move between buffers
nnoremap <leader>b :bn<CR>
nnoremap <leader>B :bp<CR>
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
let g:airline#extensions#tabline#enabled = 1 "Enable the list of buffers top
let g:airline#extensions#branch#enabled=1

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

"vim-gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

"quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#00dfff' gui=bold,underline ctermfg=45 cterm=bold,underline
highlight QuickScopeSecondary guifg='#afff5f' gui=bold,underline ctermfg=155 cterm=bold,underline

"vim-sneak
let g:sneak#label = 1
"This is to avoid ; , being mapped by sneak
map <F10> <Plug>Sneak_,
map <F10> <Plug>Sneak_;
highlight SneakLabel guifg='#5fffff' guibg=black gui=bold,underline ctermfg=45 cterm=underline
highlight SneakScope guifg='#afff5f' guibg=black gui=bold,underline ctermfg=45 cterm=underline
" NOTE: uses z in operater pending mode. e.g dz{char}{char}

source $HOME/.config/nvim/plug-config/coc.vim

