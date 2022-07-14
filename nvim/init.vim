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


"PLUGINS configuration
lua require("plug-config/coc")                          -- coc.vim
lua require("plug-config/gruvbox")                      -- gruvbox | theme
lua require("plug-config/nvimTree")                     -- nvim-tree | file explorer
lua require("plug-config/lualine")                      -- lualine.nvim | statusline
lua require("plug-config/bufferline")                   -- bufferline.nvim
lua require("plug-config/treeSitter")                   -- tree-sitter
lua require("plug-config/gitFugitive")                  -- vim-fugitive
lua require("plug-config/gitGutter")                    -- vim-gitgutter
lua require("plug-config/aerial")                       -- aerial | code outline
lua require("plug-config/hop")                          -- hop.vim
lua require("plug-config/fzf")                          -- fzf | fuzzy search finder
lua require("plug-config/vimspector")                   -- vimspector | debuggging

" vim-commentary
autocmd FileType json setlocal commentstring=//\ %s

"quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#00dfff' gui=bold,underline ctermfg=45 cterm=bold,underline
highlight QuickScopeSecondary guifg='#afff5f' gui=bold,underline ctermfg=155 cterm=bold,underline

" vimade | fades inactive windows
nmap <leader>tf :VimadeToggle<CR>



" vim-repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
