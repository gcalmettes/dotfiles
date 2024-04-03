-- Export function to be used in other modules
local M = {}

M.SetupOceanicNext = function()
  vim.api.nvim_command('colorscheme OceanicNext')
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
