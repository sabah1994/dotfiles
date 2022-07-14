local set = vim.opt

-- general
set.encoding = "utf-8"                                  --default encoding
set.syntax = "on"                                       --critical for better syntax highlighting
set.scrolloff = 7                                       --allow n lines at the bottom and top
set.ignorecase = true                                   --ignore case in search
set.laststatus = 3                                      --global statusline
set.cmdheight = 2                                       --screen lines for command-line
set.updatetime = 300                                    --quciker update  time for better experience
set.shortmess = vim.o.shortmess ..  "c"
vim.g["python3_host_prog"] = "~/vim_venv/bin/python"    --python virtualenv path
if vim.fn.exists("+termguicolors") then
    vim.opt.termguicolors = true                        -- true colours for nvim in tmux
end

-- signcolumn
set.number = true                                       --show cursorline number
set.relativenumber = true                               --relative line numbers
if  vim.fn.has("nvim-0.5.0") or vim.fn.has("patch-8.1.1564") then
    set.signcolumn = "number"                           -- display signs in the 'number' column
else
    set.signcolumn = "yes"
end

-- cursorline
set.cursorline = true                                   --highlight cursor line
set.cursorlineopt = "line"                              --do not highlight sign column in cursorline

-- disable backups for coc
set.backup = false
set.writebackup = false

-- swap files
set.swapfile = true                                     --swap files
set.dir = os.getenv("HOME") .. "/tmp"                   --swap file directory

-- fold
set.foldmethod = "expr"                                 --treesitter for folds
set.foldexpr = "nvim_treesitter#foldexpr()"             --treesitter for folds
set.foldenable = false                                  --do not auto create folds when file opens
set.foldnestmax = 3                                     --max nested fold level
set.foldlevel = 2                                       --fold level: zr or zm


--4 spaces with tab
set.tabstop = 4                                         --number of spaces that a <Tab> in the file counts for
set.shiftwidth = 4                                      --this determines indent guide and formating (invalid [--python--])
set.expandtab = true
set.clipboard = "unnamedplus"                           --copy to system clipboard

-- better split window locations
set.splitright = true                                   --default vertical split to right
set.splitbelow = true                                   --default horizental split to below

