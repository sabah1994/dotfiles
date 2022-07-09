local set = vim.opt

set.swapfile = true                                     --swap files
set.dir= "~/tmp"                                        --swap file directory
set.foldmethod = "expr"                                 --treesitter for folds
set.foldexpr = "nvim_treesitter#foldexpr()"              --treesitter for folds
set.foldenable = false                                  --do not auto create folds when file opens
set.foldnestmax = 3                                     --max nested fold level
set.foldlevel = 2                                       --fold level: zr or zm
set.encoding = "utf-8"                                  --default encoding
set.number = true
set.relativenumber = true                               --line numbers in signcolumn
set.syntax = "on"                                       --critical for better syntax highlighting
set.scrolloff = 7                                       --allow n lines at the bottom and top
set.ignorecase = true                                   --ignore case in search
--4 spaces with tab
set.tabstop = 4                                         --number of spaces that a <Tab> in the file counts for
set.shiftwidth = 4                                      --this determines indent guide and formating (invalid [--python--])
set.expandtab = true
set.clipboard = "unnamedplus"                          --copy to system clipboard
-- better split window locations
set.splitright = true                                  --default vertical split to right
set.splitbelow = true                                  --default horizental split to below
set.laststatus = 3                                     --global statusline
set.cursorline = true                                  --highlight cursor line
set.cursorlineopt = "line"                             --do not highlight sign column
