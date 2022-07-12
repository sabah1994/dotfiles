-- get rid of traling whitespace
local function TrimWhiteSpace()
    local save = vim.fn.winsaveview()
    vim.api.nvim_command([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
end
vim.api.nvim_create_autocmd("BufWritePre", {pattern = '*', callback = TrimWhiteSpace })
