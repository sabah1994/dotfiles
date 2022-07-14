" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'                                      "Theme
Plug 'kyazdani42/nvim-web-devicons'                         "File Icons
Plug 'kyazdani42/nvim-tree.lua'                             "File explorer
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
Plug 'tpope/vim-repeat'                                     "Repeat macros and plug mappings with dot
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
lua require('options')
lua require('keyMappings')
lua require('autocmds')

" vim-commentary
autocmd FileType json setlocal commentstring=//\ %s


"PLUGINS configuration

"coc.vim
lua require("plug-config/coc")

"gruvbox | theme
lua require("plug-config/gruvbox")

"nvim-tree | file explorer
lua require("plug-config/nvimTree")

" lualine.nvim | statusline
lua require("plug-config/lualine")

"bufferline.nvim
lua require("plug-config/bufferline")

"tree-sitter
lua require("plug-config/treeSitter")

"vim-fugitive
lua require("plug-config/gitFugitive")

"vim-gitgutter
lua require("plug-config/gitGutter")

" Aerial | code outline
lua require("plug-config/aerial")

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

" vim-repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
