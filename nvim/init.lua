local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.vim/plugged")
    Plug("morhetz/gruvbox") -- Theme
    Plug("kyazdani42/nvim-web-devicons") -- File Icons
    Plug("kyazdani42/nvim-tree.lua") -- File explorer
    Plug("tpope/vim-commentary") -- Comment easily
    Plug("nvim-lualine/lualine.nvim") -- Status line
    Plug("akinsho/bufferline.nvim", { tag = 'v2.*' }) -- Bufferline
    Plug("tpope/vim-fugitive") -- Git integration
    Plug("neoclide/coc.nvim", { branch = 'release' }) -- Conquer of Completion
    Plug("honza/vim-snippets") -- Snippets
    Plug("PeterRincker/vim-searchlight") -- Under cursor highlighted text in different colour
    Plug("TaDaa/vimade") -- Show inactive windows in different colours
    Plug("lukas-reineke/indent-blankline.nvim") -- Indent guide
    Plug("airblade/vim-gitgutter") -- Show git changes on left
    Plug("psliwka/vim-smoothie") -- Smooth scroll
    Plug("unblevable/quick-scope") -- Highlights chars in current line to move easily
    Plug("phaazon/hop.nvim") -- Easy hop around
    Plug("tpope/vim-surround") -- Easy text-object surrounding plugin
    Plug("tpope/vim-repeat") -- Repeat macros and plug mappings with dot
    Plug("nvim-treesitter/nvim-treesitter", { ['do'] = ':TSUpdate' }) -- Syntax tree plugin
    Plug("nvim-treesitter/nvim-treesitter-textobjects") -- Text objects based on treesitter
    Plug("christoomey/vim-tmux-navigator") -- Easy navigation between tmux panes and vim windows
    Plug("mhinz/vim-startify") -- Startup screen
    Plug("puremourning/vimspector") -- Debugger
    Plug("junegunn/fzf", { ['do'] = vim.fn['fzf#install'] }) -- Installs FZF
    Plug("junegunn/fzf.vim") -- Fuzzy finder
    Plug("stevearc/aerial.nvim") -- Code outline
    Plug("jiangmiao/auto-pairs") -- Auto pairs
vim.call("plug#end")


-- Basic configuration
require("options")
require("keyMappings")
require("autocmds")


-- PLUGINS configuration
require("plug-config/coc") -- coc.vim
require("plug-config/gruvbox") -- gruvbox | theme
require("plug-config/nvimTree") -- nvim-tree | file explorer
require("plug-config/lualine") -- lualine.nvim | statusline
require("plug-config/bufferline") -- bufferline.nvim
require("plug-config/treeSitter") -- tree-sitter
require("plug-config/gitFugitive") -- vim-fugitive
require("plug-config/gitGutter") -- vim-gitgutter
require("plug-config/aerial") -- aerial | code outline
require("plug-config/hop") -- hop.vim
require("plug-config/fzf") -- fzf | fuzzy search finder
require("plug-config/vimspector") -- vimspector | debuggging
require('plug-config/quickScope') -- quick-scope

-- vim-commentary
vim.api.nvim_create_autocmd("FileType", { pattern = { "json" }, command = [[setlocal commentstring=//\ %s]] })

-- vimade | fades inactive windows
vim.api.nvim_set_keymap("n", "<leader>tf", ":VimadeToggle<CR>", { noremap = true })

-- vim-repeat
vim.api.nvim_command([[silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)]])
