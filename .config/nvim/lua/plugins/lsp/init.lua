local custom_on_init = function(name)
  return function()
    print("Language Server Protocol started:", name, "!")
  end
end

local custom_capabilities = function()
  -- local capabilities = require("cmp_nvim_lsp").default_capabilities(
  --   vim.lsp.protocol.make_client_capabilities()
  -- )
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end


local servers = {
  tsserver = require("plugins.lsp.javascript").config,
  html = {},
  jsonls = require("plugins.lsp.json").config,
  bashls = {},
  cssls = {},
  rust_analyzer = require("plugins.lsp.rust").config,
  pyright = require("plugins.lsp.pyright").config,
  gopls = require("plugins.lsp.gopls").config,
  terraformls = require("plugins.lsp.terraformls").config,
}

local function setup_with_options()
  local nvim_lsp = require("lspconfig")
  for name, opts in pairs(servers) do
    local client = nvim_lsp[name]
    local server_opts = {
        cmd = opts.cmd or client.cmd,
        filetypes = opts.filetypes or client.filetypes,
        on_attach = opts.on_attach or nil,
        on_init = opts.on_init or custom_on_init(name),
        handlers = opts.handlers or client.handlers,
        root_dir = opts.root_dir or client.root_dir,
        capabilities = opts.capabilities or custom_capabilities(),
        settings = opts.settings or {},
    }
    if opts.override_client_setup then
      opts.override_client_setup(server_opts)
    else
      client.setup(server_opts)
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
