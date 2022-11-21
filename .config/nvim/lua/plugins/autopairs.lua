require('nvim-autopairs').setup()

require("nvim-autopairs.completion.compe").setup({
  --  map <CR> on insert mode
  map_cr = true,
  -- it will auto insert `(` after select function or method item
  map_complete = true
})
