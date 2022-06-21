local M = {}

M.plugin = {
  "nvim-treesitter/nvim-treesitter",
  run = ':TSUpdate',
  config = function()
    require("plugins.treesitter").config()
  end,
}

M.config = function()
  local ts_config = require("nvim-treesitter.configs");

  ts_config.setup {
    ensure_installed = {
      "python",
      "go",
      "rust",
      "javascript",
      "bash",
      "html",
      "css",
      "scss",
      "yaml",
      "toml",
      "json",
      "rst",
      "regex",
      "lua",
      "latex",
      "dockerfile",
      "cmake",
      "tsx",
      "comment",
      "query",
      "hcl" -- terraform
    },
    matchup = { enable = true },
    highlight = { enable = true },
    indent = { enable = false }, -- wait until it's back to normal
  }

end

return M
