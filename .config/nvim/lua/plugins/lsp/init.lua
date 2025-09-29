local custom_capabilities = function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  return capabilities
end


local servers = {
  ts_ls = require("plugins.lsp.javascript").config,
  html = {},
  jsonls = require("plugins.lsp.json").config,
  bashls = {},
  cssls = {},
  rust_analyzer = require("plugins.lsp.rust").config,
  pyright = require("plugins.lsp.pyright").config,
  protols = {},
  gopls = require("plugins.lsp.gopls").config,
  terraformls = require("plugins.lsp.terraformls").config,
}

local function setup_with_options()
  for name, opts in pairs(servers) do
    local cfg = vim.lsp.config[name]
    local server_opts = {
        cmd = opts.cmd or cfg.cmd,
        filetypes = opts.filetypes or cfg.filetypes,
        on_attach = opts.on_attach or nil,
        on_init = opts.on_init or nil,
        handlers = opts.handlers or cfg.handlers,
        root_dir = opts.root_dir or cfg.root_dir,
        capabilities = opts.capabilities or custom_capabilities(),
        settings = opts.settings or {},
    }
    if opts.override_client_setup then
      opts.override_client_setup(server_opts)
    else
      vim.lsp.enable(name, server_opts)
    end
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      setup_with_options()
    end
  },
}
