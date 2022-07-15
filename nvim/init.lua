local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.vim/plugged")
-- UI
Plug("morhetz/gruvbox")                                         -- Theme
Plug("kyazdani42/nvim-web-devicons")                            -- File Icons
Plug("kyazdani42/nvim-tree.lua")                                -- File explorer
Plug("nvim-lualine/lualine.nvim")                               -- Status line
Plug("akinsho/bufferline.nvim", { tag = 'v2.*' })               -- Bufferline
Plug("PeterRincker/vim-searchlight")                            -- Under cursor highlighted text in different colour
Plug("lukas-reineke/indent-blankline.nvim")                     -- Indent guide
Plug("TaDaa/vimade")                                            -- Show inactive windows in different colours
Plug("karb94/neoscroll.nvim")                                   -- Smooth scroll
Plug("mhinz/vim-startify")                                      -- Startup screen

-- Autocompletion And IDE Features
Plug("neoclide/coc.nvim", { branch = 'release' })               -- Conquer of Completion
Plug("honza/vim-snippets")                                      -- Snippets

-- Motions | Movements
Plug("phaazon/hop.nvim")                                        -- Easy hop around
Plug("unblevable/quick-scope")                                  -- Highlights chars in current line to move easily
Plug("christoomey/vim-tmux-navigator")                          -- Easy navigation between tmux panes and vim windows

-- Text objects
Plug("tpope/vim-surround")                                      -- Easy text-object surrounding plugin

-- Git
Plug("tpope/vim-fugitive")                                      -- Git integration
Plug("airblade/vim-gitgutter")                                  -- Show git changes on left

-- TreeSitter
Plug("nvim-treesitter/nvim-treesitter", { ['do'] = ':TSUpdate' }) -- Syntax tree plugin
Plug("nvim-treesitter/nvim-treesitter-textobjects")             -- Text objects based on treesitter

-- General
Plug("tpope/vim-commentary")                                    -- Comment easily
Plug("tpope/vim-repeat")                                        -- Repeat macros and plug mappings with dot
Plug("puremourning/vimspector")                                 -- Debugger
Plug("junegunn/fzf", { ['do'] = vim.fn['fzf#install'] })        -- Installs FZF
Plug("junegunn/fzf.vim")                                        -- Fuzzy finder
Plug("stevearc/aerial.nvim")                                    -- Code outline
Plug("jiangmiao/auto-pairs")                                    -- Auto pairs
vim.call("plug#end")


-- Basic configuration
require("options")
require("keyMappings")
require("autocmds")


-- PLUGINS configuration
require("plug-config/coc")                                      -- coc.vim
require("plug-config/gruvbox")                                  -- gruvbox | theme
require("plug-config/nvimTree")                                 -- nvim-tree | file explorer
require("plug-config/lualine")                                  -- lualine.nvim | statusline
require("plug-config/bufferline")                               -- bufferline.nvim
require("plug-config/treeSitter")                               -- tree-sitter
require("plug-config/gitFugitive")                              -- vim-fugitive
require("plug-config/gitGutter")                                -- vim-gitgutter
require("plug-config/aerial")                                   -- aerial | code outline
require("plug-config/hop")                                      -- hop.vim
require("plug-config/fzf")                                      -- fzf | fuzzy search finder
require("plug-config/vimspector")                               -- vimspector | debuggging
require('plug-config/quickScope')                               -- quick-scope

-- vim-commentary
vim.api.nvim_create_autocmd("FileType", { pattern = { "json" }, command = [[setlocal commentstring=//\ %s]] })

-- vimade | fades inactive windows
vim.api.nvim_set_keymap("n", "<leader>tf", ":VimadeToggle<CR>", { noremap = true })

-- vim-repeat
vim.api.nvim_command([[silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)]])

-- neoscroll
require('neoscroll').setup()
