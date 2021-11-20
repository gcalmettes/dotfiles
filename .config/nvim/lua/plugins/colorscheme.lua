local opt = vim.opt
local cmd = vim.cmd
local execute = vim.api.nvim_command

-- True color support
opt.termguicolors = true

cmd 'colorscheme OceanicNext'

cmd [[au VimEnter * hi Normal guibg=NONE ctermbg=NONE]]
cmd [[au VimEnter * hi LineNr guibg=NONE ctermbg=NONE]]
cmd [[au VimEnter * hi SignColumn guibg=NONE ctermbg=NONE]]
cmd [[au VimEnter * hi EndOfBuffer guibg=NONE ctermbg=NONE]]


--local VimOceanicNextHighlights = function()
--    vim.api.nvim_exec([[
--      function! MyHighlights() abort
--        hi Normal guibg=NONE ctermbg=NONE
--        hi LineNr guibg=NONE ctermbg=NONE
--        hi SignColumn guibg=NONE ctermbg=NONE
--        hi EndOfBuffer guibg=NONE ctermbg=NONE
--      endfunction
--
--      augroup MyColors
--          autocmd!
--          autocmd ColorScheme * call MyHighlights()
--      augroup END
--    ]], false)
--end
--
--VimOceanicNextHighlights()

--require('colorbuddy').colorscheme('mhartington/oceanic-next', 'dark', {disable_defaults = true})
