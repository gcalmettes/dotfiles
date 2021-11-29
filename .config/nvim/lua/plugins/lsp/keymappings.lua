local nnoremap = require("astronauta.keymap").nnoremap
local inoremap = require("astronauta.keymap").inoremap

local M = {}

-- local provider = require"lspsaga.provider"
local hover = require("lspsaga.hover")
local sig_help = require("lspsaga.signaturehelp")
local rename = require("lspsaga.rename")
local diagnostic = require("lspsaga.diagnostic")
local provider = require("lspsaga.provider")
local codeaction = require("lspsaga.codeaction")
local action = require("lspsaga.action")
local rename = require("lspsaga.rename")

M.lsp_mappings = function(type)

  -- go to definition
  nnoremap({ "gd", '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true } })
  -- lsp provider to find the cursor word definition and reference
  nnoremap({ "gh", provider.lsp_finder, { silent = true } })
  -- preview definition
  nnoremap({ "gp", provider.preview_definition, { silent = true } })
  -- code action
  nnoremap({ "ca", codeaction.code_action, { silent = true } })
  nnoremap({ "<leader>ca", codeaction.range_code_action, { silent = true } })
  nnoremap({ "ga", require("telescope.builtin").lsp_code_actions, { silent = true } })
  -- show hover doc
  nnoremap({ "K", hover.render_hover_doc, { silent = true } })
  -- scroll down hover doc or scroll in definition preview
  nnoremap({ "<C-f>", function() action.smart_scroll_with_saga(1) end, { silent = true } })
  -- show signature help
  inoremap({ "<C-s>", sig_help.signature_help, { silent = true } })
  -- rename
  -- nnoremap({ "gr", require("telescope.builtin").lsp_references, { silent = true } })
  nnoremap({ "gr", rename.rename, { silent = true } })
  -- close rename win use <C-c> in insert mode or `q` in normal mode or `:q`
  nnoremap({ "<C-r>", require("telescope.builtin").lsp_references, { silent = true } })
  -- Diagnostics
  -- show diagnostic
  nnoremap({ "<Leader>cd", diagnostic.show_line_diagnostics, { silent = true } })
  nnoremap({ "<Leader>cc", diagnostic.show_cursor_diagnostics, { silent = true } })
  -- jump diagnostic
  -- nnoremap({ "<Leader>dn", diagnostic.navigate("next")(), { silent = true } })
  -- nnoremap({ "<Leader>dn", diagnostic.navigate("prev")(), { silent = true } })

end

return M
