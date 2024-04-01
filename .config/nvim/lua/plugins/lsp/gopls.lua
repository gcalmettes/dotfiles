local M = {}

M.config = {
  -- root_dir = vim.loop.cwd,
  -- cmd = {'gopls', 'serve'},
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      staticcheck = true,
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        -- shadow = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      semanticTokens = true,
    },
  },
}

return M
