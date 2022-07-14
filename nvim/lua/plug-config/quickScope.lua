-- only trigger on these keys
vim.g["qs_highlight_on_keys"] = { 'f', 'F', 't', 'T' }

-- highlights
vim.highlight.create("QuickScopePrimary", { guifg = '#00dfff', gui = "bold,underline", ctermfg = 45,
    cterm = "bold,underline" })
vim.highlight.create("QuickScopeSecondary", { guifg = '#afff5f', gui = "bold,underline", ctermfg = 155,
    cterm = "bold,underline" })
