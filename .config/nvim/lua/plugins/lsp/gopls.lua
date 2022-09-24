local M = {}


function organize_goimports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

-- Format file and organize Go imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function(args)
        vim.lsp.buf.formatting_sync()
        organize_goimports(1000)
    end,
    desc = "Format Go files",
})

M.config = {
  root_dir = vim.loop.cwd,
  cmd = {'gopls', 'serve'},
  -- on_attach = function(client, bufnr)
  --   local map = vim.keymap.set
  --   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  --   -- Mappings.
  --   local opts = { silent=true, buffer=bufnr }
  --   -- map('n', 'gD', vim.lsp.buf.declaration, opts)
  --   -- map('n', 'gd', vim.lsp.buf.definition, opts)
  --   -- map('n', 'ga', vim.lsp.buf.code_action, opts)
  --   map('n', 'K', vim.lsp.buf.hover, opts)
  --   -- map('n', 'gi', vim.lsp.buf.implementation, opts)
  --   map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  --   -- map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  --   -- map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  --   -- map('n', '<space>wl', print(vim.inspect(vim.lsp.buf.list_workspace_folders())), opts)
  --   -- map('n', '<space>D', vim.lsp.buf.type_definition, opts)
  --   map('n', 'gr', vim.lsp.buf.rename, opts)
  --   map('n', '<C-r>', vim.lsp.buf.references, opts)
  --   -- map('n', '<space>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
  --   -- map('n', '[d', vim.lsp.diagnostic.goto_prev, opts)
  --   -- map('n', ']d', vim.lsp.diagnostic.goto_next, opts)
  --   -- map('n', '<space>q', vim.lsp.diagnostic.set_loclist, opts)

  --   -- Set some keybinds conditional on server capabilities
  --   if client.resolved_capabilities.document_formatting then
  --     map("n", "ff", vim.lsp.buf.formatting, opts)
  --   elseif client.resolved_capabilities.document_range_formatting then
  --     map("n", "ff", vim.lsp.buf.range_formatting, opts)
  --   end

  --   -- Set autocommands conditional on server_capabilities
  --   if client.resolved_capabilities.document_highlight then
  --     vim.api.nvim_exec([[
  --       hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
  --       hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
  --       hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
  --       augroup lsp_document_highlight
  --         autocmd! * <buffer>
  --         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --       augroup END
  --     ]], false)
  --   end
  -- end,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
    },
    staticcheck = true,
    },
  },
}

return M
