require('aerial').setup({
  default_direction = "left",
  nerd_font = true,
  show_guides = true
})

-- toggle | also disables fade plugin
vim.api.nvim_set_keymap( "n", "<leader>to", ":VimadeDisable <CR> :AerialToggle<CR>", {})
vim.api.nvim_command("hi link AerialLine CursorLineNr")
