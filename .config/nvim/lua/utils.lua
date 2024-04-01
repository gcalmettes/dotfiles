-- local SetupOceanicNext = function()
--   -- setup Oceanic Next colorScheme
--   vim.api.nvim_command('colorscheme OceanicNext')
--     -- Add transparency support for NeoVim
--   vim.api.nvim_command('au VimEnter * hi Normal guibg=NONE ctermbg=NONE')
--   vim.api.nvim_command('au VimEnter * hi LineNr guibg=NONE ctermbg=NONE')
--   vim.api.nvim_command('au VimEnter * hi SignColumn guibg=NONE ctermbg=NONE')
--   vim.api.nvim_command('au VimEnter * hi EndOfBuffer guibg=NONE ctermbg=NONE')
-- end

-- local function keymap(mode, lhs, rhs, opts)
--     local options = { noremap = true, silent = true }
--     if opts then
--         options = vim.tbl_extend("force", options, opts)
--     end
--     vim.keymap.set(mode, lhs, rhs, options)
-- end


-- Export function to be used in other modules
local M = {}

M.SetupOceanicNext = function()
  -- setup Oceanic Next colorScheme
  vim.api.nvim_command('colorscheme OceanicNext')
    -- Add transparency support for NeoVim
  vim.api.nvim_command('au VimEnter * hi Normal guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('au VimEnter * hi LineNr guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('au VimEnter * hi SignColumn guibg=NONE ctermbg=NONE')
  vim.api.nvim_command('au VimEnter * hi EndOfBuffer guibg=NONE ctermbg=NONE')
end

M.SetupDefaultColorScheme = function()
  M.SetupOceanicNext()
end

M.Keymap = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
      options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

M.is_file_present = function(filename)
  -- this returns 1 if it's not present and 0 if it's present
  -- we need to compare it with 1 because both 0 and 1 is `true` in lua
  return fn.empty(fn.glob(vim.loop.cwd() .. filename)) ~= 1
end

return M
