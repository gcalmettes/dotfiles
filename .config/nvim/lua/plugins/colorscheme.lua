local opt = vim.opt
local cmd = vim.cmd
local execute = vim.api.nvim_command

-- True color support
opt.termguicolors = true


local SetupOceanicNext = function()
  -- setup Oceanic Next colorScheme
  vim.api.nvim_command('colorscheme OceanicNext')
    -- Add transparency support for NeoVim
  vim.api.nvim_command('au VimEnter * hi Normal guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('au VimEnter * hi LineNr guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('au VimEnter * hi SignColumn guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('au VimEnter * hi EndOfBuffer guibg=NONE ctermbg=NONE')
end

SetupOceanicNext()

-- Export function to be used in other modules

local M = {}

M.SetupDefaultColorScheme = function()
  SetupOceanicNext()
end

return M

