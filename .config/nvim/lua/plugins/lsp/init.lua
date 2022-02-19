vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd lspsaga.nvim]]

local nvim_lsp = require("lspconfig")
local mappings = require("plugins.lsp.keymappings")

require("lspsaga").init_lsp_saga({
  -- default values
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  dianostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  -- border_style = "single",
  border_style = "round", -- default: "single"
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
})

local custom_on_attach = function(client)
  mappings.lsp_mappings()

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

end

local custom_on_init = function()
  print("Language Server Protocol started!")
end

local custom_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end


local servers = {
  tsserver = require("plugins.lsp.javascript").config,
  html = {},
  jsonls = require("plugins.lsp.json").config,
  cssls = {},
  rust_analyzer = require("plugins.lsp.rust").config,
  pyright = require("plugins.lsp.pyright").config,
  gopls = require("plugins.lsp.gopls").config,
}


for name, opts in pairs(servers) do
  local client = nvim_lsp[name]
  local server_opts = {
      cmd = opts.cmd or client.cmd,
      filetypes = opts.filetypes or client.filetypes,
      on_attach = opts.on_attach or custom_on_attach,
      on_init = opts.on_init or custom_on_init,
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
