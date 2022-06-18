lua << EOF
require'nvim-treesitter.configs'.setup {
    -- TS parsers
    ensure_installed = { "c",
        "python",
        "java",
        "bash",
        "vim",
        "comment",
        "json",
        "javascript",
        "typescript",
        "html",
        "css"
    },

    -- TS modules
    highlight = {
        enable = true,
        disable = {"rust" },
    },
}
EOF
