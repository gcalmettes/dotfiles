local map = vim.keymap.set
local telescope = require "telescope.builtin"

local diagnostic_opts = {
  focusable = false,

  border = {
    -- fancy border
    { "🭽", "FloatBorder" },
    { "▔", "FloatBorder" },
    { "🭾", "FloatBorder" },
    { "▕", "FloatBorder" },
    { "🭿", "FloatBorder" },
    { "▁", "FloatBorder" },
    { "🭼", "FloatBorder" },
    { "▏", "FloatBorder" },

    -- -- padding border
    -- {"▄", "Bordaa"},
    -- {"▄", "Bordaa"},
    -- {"▄", "Bordaa"},
    -- {"█", "Bordaa"},
    -- {"▀", "Bordaa"},
    -- {"▀", "Bordaa"},
    -- {"▀", "Bordaa"},
    -- {"█", "Bordaa"}
  },
  severity_sort = true,
  scope = "line",
}


-- Show diagnostic popup on cursor hover
local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
   vim.diagnostic.open_float(nil, diagnostic_opts)
  end,
  group = diag_float_grp,
})

local M = {}

M.lsp_mappings = function(bufnr)
  map("i", "<Leader>k", vim.lsp.buf.signature_help, {
    desc = "Trigger signature help from the language server",
    silent = true,
  })

  map("n", "<C-k>", vim.lsp.buf.signature_help, {
    desc = "Trigger signature help from the language server",
    silent = true,
  })

  map("n", "K", vim.lsp.buf.hover, {
    desc = "Display documentation of the symbol under the cursor",
    silent = true,
  })

  map("n", "<Leader>ga", vim.lsp.buf.code_action, {
    desc = "Pick code actions from the language server",
    silent = true,
  })

  map("n", "<Leader>gd", vim.lsp.buf.definition, {
    desc = "Go to symbol definition",
    silent = true,
    buffer=bufnr,
  })

  map("n", "<Leader>gl", vim.lsp.codelens.run, {
    desc = "Run codelens from the language server",
    silent = true,
  })

  map("n", "<Leader>gD", function()
      vim.diagnostic.open_float(0, diagnostic_opts)
    end, {
    desc = "See diagnostics in floating window",
    silent = true,
  })

  map("n", "<Leader>gr", telescope.lsp_references, {
    desc = "Find symbol references using telescope",
    silent = true,
  })

  map("n", "<Leader>gs", telescope.lsp_workspace_symbols, {
    desc = "Find workspace symbols using Telescope",
    silent = true,
  })

  map("n", "<Leader>gR", vim.lsp.buf.rename, {
    desc = "Rename current symbol",
    silent = true,
  })

  map("n", "<Leader>g]", function()
      vim.diagnostic.goto_next {
        float = { show_header = false, border = Util.borders },
      }
    end, {
    desc = "Go to next diagnostic",
    silent = true,
  })

  map("n", "<Leader>g[", function()
      vim.diagnostic.goto_prev {
        float = { show_header = false, border = Util.borders },
      }
    end, {
    desc = "Go to previous diagnostic",
    silent = true,
  })
end

return M
