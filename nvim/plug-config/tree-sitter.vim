lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "python", "java", "bash", "vim", "comment"},

    highlight = {
        enable = true,
        disable = {"rust" },
    },
}
EOF
