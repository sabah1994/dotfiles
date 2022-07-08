" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'                                      "Theme
Plug 'preservim/nerdtree'                                   "File explorer
Plug 'kyazdani42/nvim-web-devicons'                         "Icons
Plug 'ryanoasis/vim-devicons'                               "File icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'              "Correct colour for icons
Plug 'tpope/vim-commentary'                                 "Comment easily
Plug 'nvim-lualine/lualine.nvim'                            "Status line
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }           "Bufferline
Plug 'tpope/vim-fugitive'                                   "Git integration
Plug 'neoclide/coc.nvim', {'branch': 'release'}             "Conquer of Completion
Plug 'honza/vim-snippets'                                   "Snippets
Plug 'PeterRincker/vim-searchlight'                         "Under cursor highlighted text in different colour
Plug 'TaDaa/vimade'                                         "Show inactive windows in different colours
Plug 'lukas-reineke/indent-blankline.nvim'                  "Indent guide
Plug 'airblade/vim-gitgutter'                               "Show git changes on left
Plug 'psliwka/vim-smoothie'                                 "Smooth scroll
Plug 'unblevable/quick-scope'                               "Highlights chars in current line to move easily
Plug 'phaazon/hop.nvim'                                     "Easy hop around
Plug 'tpope/vim-surround'                                   "Easy text-object surrounding plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}  "Syntax tree plugin
Plug 'nvim-treesitter/nvim-treesitter-textobjects'          "Text objects based on treesitter
Plug 'christoomey/vim-tmux-navigator'                       "Easy navigation between tmux panes and vim windows
Plug 'mhinz/vim-startify'                                   "Startup screen
Plug 'puremourning/vimspector'                              "Debugger
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }         "Installs FZF
Plug 'junegunn/fzf.vim'                                     "Fuzzy finder
Plug 'stevearc/aerial.nvim'                                 "Code outline
call plug#end()

"true colours for nvim in tmux
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


" Basic configuration
let mapleader = " "                                         "map leader to space
nnoremap <SPACE> <Nop>
set swapfile                                                "swap files
set dir=~/tmp                                               "swap file directory
set foldmethod=expr                                         "treesitter for folds
set foldexpr=nvim_treesitter#foldexpr()                     "treesitter for folds
set nofoldenable                                            "do not auto create folds when file opens
set foldnestmax=3                                           "max nested fold level
set foldlevel=2                                             "fold level: zr or zm
set encoding=utf-8                                          "default encoding
set number relativenumber                                   "line numbers in signcolumn
syntax on                                                   "critical for better syntax highlighting
set scrolloff=7                                             "allow n lines at the bottom and top
set ignorecase                                              "ignore case in search
"4 spaces with tab
set tabstop=4                                               "number of spaces that a <Tab> in the file counts for
set shiftwidth=4                                            "this determines indent guide and formating (invalid ["python"])
set expandtab
set clipboard=unnamedplus                                   "copy to system clipboard
" better split window locations
set splitright                                              "default vertical split to right
set splitbelow                                              "default horizental split to below
set laststatus=3                                            "global statusline
set cursorline                                              "highlight cursor line
set cursorlineopt=line                                      "do not highlight sign column


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

" Buffers shortcuts
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>d :bdelete<CR>
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>

" Easier split window
nnoremap <leader>\| :vsplit<CR>
nnoremap <leader>- :split<CR>

" Edit common files quickly
nnoremap <Leader>ev :edit $MYVIMRC<cr>
nnoremap <Leader>ez :edit ~/.zshrc<cr>
nnoremap <Leader>so  :so $MYVIMRC<cr>

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
" toggle diagnostics
nmap <leader>ta :call CocAction('diagnosticToggle')<CR>

"gruvbox | theme
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = "bg0"
let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
colorscheme gruvbox
" For even darker background
"cd ~/.vim/plugged/gruvbox/colors/gruvbox.vim let s:gb.dark0_hard  = ['#171717', 233]     " 29-32-33
"Line 591 change to: hi! link Operator GruvboxFg1 (https://github.com/morhetz/gruvbox/issues/260)
hi! CocHintSign guifg=#f5e342

"nerdtree
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1                                                "close NERDTree when file open
let NERDTreeWinSize = 50                                                "NT win size
let NERDTreeShowHidden=1                                                "show hidden files
let NERDTreeIgnore=['\.git$', 'venv$', '__pycache__$']                  "ignore git folder

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
nmap <leader>ghs <Plug>(GitGutterStageHunk)
xmap <leader>ghs <Plug>(GitGutterStageHunk)
nmap <leader>ghu <Plug>(GitGutterUndoHunk)
nmap <leader>ghp <Plug>(GitGutterPreviewHunk)
"text-objects
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)
"toggle
nmap tg :GitGutterToggle<CR>

"quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#00dfff' gui=bold,underline ctermfg=45 cterm=bold,underline
highlight QuickScopeSecondary guifg='#afff5f' gui=bold,underline ctermfg=155 cterm=bold,underline

" hop.vim
lua << EOF
require'hop'.setup()
EOF
"Not mapping s in operator mode because it's taken by surround
nmap s <cmd>HopChar1<CR>
vmap s <cmd>HopChar1<CR>
map <leader>k <cmd>HopLineBC<CR>
map <leader>j <cmd>HopLineAC<CR>
map <leader><leader>k <cmd>HopWordBC<CR>
map <leader><leader>j <cmd>HopWordAC<CR>

" vimade | fades inactive windows
nmap <leader>tf :VimadeToggle<CR>

" vimspector | debuggging <<==================================>>
" Use arrow keys when debugging, makes it much simpler.
" Because debug mode is rare, only map keys when it's turned on
let s:vimSpectroDebugMode=0
function ToggleKeysForDebug()
    if s:vimSpectroDebugMode
        unmap <Up>
        unmap <Left>
        unmap <Right>
        unmap <Down>
        echom "DebugMode is OFF"
    else
        nnoremap <Leader>ds :call vimspector#Launch()<CR>
        nnoremap <Leader>de :call vimspector#Reset()<CR>
        nnoremap <Leader>dc :call vimspector#Continue()<CR>
        " breakpoints
        nnoremap <Leader>db :call vimspector#ToggleBreakpoint()<CR>
        nnoremap <Leader>dB :call vimspector#ClearBreakpoints()<CR>
        "Arrow keys
        nmap <Up> <Plug>VimspectorRestart
        nmap <Left> <Plug>VimspectorStepOut
        nmap <Right> <Plug>VimspectorStepInto
        nmap <Down> <Plug>VimspectorStepOver
        echom "DebugMode is ON"
    endif
    let s:vimSpectroDebugMode = !s:vimSpectroDebugMode
endfunction
nnoremap <leader>td :call ToggleKeysForDebug()<CR>
" <<==========================================================>>

" fzf | fuzzy search finder
nnoremap <silent><nowait> <leader>f  :<C-u>FzfFiles<CR>
nnoremap <silent><nowait> <leader>gf  :<C-u>FzfGFiles<CR>
nnoremap <silent><nowait> <leader>b  :<C-u>FzfBuffers<CR>
nnoremap <silent><nowait> <leader>gr  :<C-u>FzfRg<CR>
nnoremap <silent><nowait> <leader>c  :<C-u>FzfCommands<CR>
"Use ag (silverSearcher) because it respects gitignore
"Even in non-git folders it respects global gitignore
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
" Add prefix for fzf commands
let g:fzf_command_prefix = 'Fzf'
" Other useful commands
" Commits   | For commits
" BCommits  | Commits related to current buffer

" Aerial | code outline
lua << EOF
require('aerial').setup({
  default_direction = "left",
  nerd_font = true,
  show_guides = true
})
EOF
" toggle | also disables fade plugin
nmap <leader>to :VimadeDisable <CR> :AerialToggle<CR>
hi link AerialLine CursorLineNr

"bufferline.nvim
lua << EOF
require("bufferline").setup{
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thick"
        -- numbers = "buffer_id"
        -- diagnostics = "coc"
    }
}
EOF

" lualine.nvim | statusline
lua << EOF
require('lualine').setup({
    sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", {"diff", symbols = {added = " ", modified = "柳", removed = "柳"}}},
        lualine_c = {
            {"filetype", padding={right=0, left=2}, icon_only = true, component_separators = {left = "", right = ""}},
            {"filename", padding={left=1}, color = {gui = "bold,italic", fg = "#ebdbb2"}}
        },
        lualine_x = {"encoding", "fileformat"},
        lualine_y = {
            {
                "diagnostics",
                sources = {"coc"},
                sections = {"info", "warn", "error"},
                symbols = {error = " "},
                always_visible = true -- Show diagnostics even if there are none.
            }
        },
        lualine_z = {"progress", "location"}
    }
})
EOF


source $HOME/.config/nvim/plug-config/tree-sitter.vim
source $HOME/.config/nvim/plug-config/coc.vim

