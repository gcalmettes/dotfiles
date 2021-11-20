vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd lspsaga.nvim]]

local nvim_lsp = require("lspconfig")
local mappings = require("plugins.lsp.keymappings")

require("lspsaga").init_lsp_saga({
  -- default values
  -- use_saga_diagnostic_sign = true,
  -- error_sign = '',
  -- warn_sign = '',
  -- hint_sign = '',
  -- infor_sign = '',
  -- dianostic_header_icon = '   ',
  -- code_action_icon = ' ',
  -- code_action_prompt = {
  --   enable = true,
  --   sign = true,
  --   sign_priority = 20,
  --   virtual_text = true,
  -- },
  -- finder_definition_icon = '  ',
  -- finder_reference_icon = '  ',
  -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
  -- finder_action_keys = {
  --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  -- },
  -- code_action_keys = {
  --   quit = 'q',exec = '<CR>'
  -- },
  -- rename_action_keys = {
  --   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
  -- },
  -- definition_preview_icon = '  '
  -- "single" "double" "round" "plus"
  -- rename_prompt_prefix = '➤',
  -- if you don't use nvim-lspconfig you must pass your server name and
  -- the related filetypes into this table
  -- like server_filetype_map = {metals = {'sbt', 'scala'}}
  -- server_filetype_map = {}
  -- border_style = "single"
  border_style = "round",
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
  rust_analyzer = {},
  pyright = require("plugins.lsp.pyright").config,
  gopls = require("plugins.lsp.gopls").config,
  yamlls = {
    settings = {
      yaml = {
         schemas = { kubernetes = "globPattern" },
      }
    }
  }
}


for name, opts in pairs(servers) do
  local client = nvim_lsp[name]
  client.setup({
    cmd = opts.cmd or client.cmd,
    filetypes = opts.filetypes or client.filetypes,
    on_attach = opts.on_attach or custom_on_attach,
    on_init = opts.on_init or custom_on_init,
    handlers = opts.handlers or client.handlers,
    root_dir = opts.root_dir or client.root_dir,
    capabilities = opts.capabilities or custom_capabilities(),
    settings = opts.settings or {},
  })
end
