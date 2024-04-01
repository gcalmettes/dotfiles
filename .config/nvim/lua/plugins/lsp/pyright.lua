local M = {}

local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}

M.config = {
  root_dir = function(fname)
    local util = require("lspconfig/util")
    return util.root_pattern(unpack(root_files))(fname) or
      util.path.dirname(fname)
  end,
}

return M
