local M = {}

-- use eslint if the eslint config file present
local is_using_eslint = function(_, _, result, client_id)
  local u = require("utils")
  if u.is_file_present("/.eslintrc.json") or u.is_file_present("/.eslintrc.js") then
    return
  end
  return vim.lsp.handlers["textDocument/publishDiagnostics"](_, _, result, client_id)
end

local opts = {
}

M.config = {
    filetypes = { "javascript", "typescript", "typescriptreact" },
    on_attach = function(client)
      mappings.lsp_mappings()

      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      client.resolved_capabilities.document_formatting = false
    end,
    init_options = {
      documentFormatting = false,
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = is_using_eslint,
    },
    root_dir = vim.loop.cwd,
  override_client_setup = function(server_opts)
    opts.server = server_opts or {}
    require('lspconfig').tsserver.setup(opts)
  end,
}

return M

