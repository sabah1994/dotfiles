require("nvim-tree").setup({
    sort_by = "case_sensitive",
    hijack_cursor = true,
    sync_root_with_cwd = true,
    git = {
        show_on_dirs = false,
        ignore = true
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
        group_empty = true, -- empty folders on the same line
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
        custom = { "venv", "__pycache__", ".git" } -- ignore folders
    },
    actions = {
        open_file = {
            quit_on_open = true,
        }
    },
})
-- keyMappings
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- highlights
-- colours for git signs
vim.highlight.create("NvimTreeGitDirty", { guifg = "#26A269" })
vim.highlight.create("NvimTreeGitStaged", { guifg = "#26A269" })

-- cursorline
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
            vim.cmd "setlocal cursorline"
        end
  end
})
