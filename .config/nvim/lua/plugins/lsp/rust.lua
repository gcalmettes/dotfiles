local M = {}

M.config = {
  -- all the opts to send to nvim-lspconfig
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy",
      },
      cargo = {
        allFeatures = true,
      },
      imports = {
        group = {
          enable = false,
        },
      },
      completion = {
        postfix = {
          enable = false,
        },
      },
    }
  },
}

return M
