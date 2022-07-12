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
let g:python3_host_prog="~/vim_venv/bin/python"

"coc.vim
lua require("plug-config/coc")

"gruvbox | theme
lua require("plug-config/gruvbox")

"nvim-tree
map <silent> <C-n> :NvimTreeToggle<CR>
lua << EOF
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    git = {
        show_on_dirs = false,
    },
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
        group_empty = true,     -- empty folders on the same line
        icons = {
            git_placement = "signcolumn",
            glyphs = {
                git = {
                    unstaged = "",
                    staged = "",
                    untracked = "留",
                }
            }
        }
    },
    diagnostics = {
        enable = true,
        show_on_dirs = false,
        icons = {
          error = "",
        },
      },
    filters = {
        -- dotfiles = true, --don't show hidden files
        custom = {"venv", "__pycache__", ".git"} -- ignore folders
        },
    actions = {
    open_file = {
            quit_on_open = true,
        }
    },
})
EOF
" Colours for git signs
highlight NvimTreeGitDirty guifg=#26A269
highlight NvimTreeGitStaged guifg=#26A269

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
        separator_style = "thick",
        numbers = "ordinal" -- or "buffer_id"
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

" vim-repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
