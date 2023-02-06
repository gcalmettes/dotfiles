require('lspconfig').terraformls.setup{}

local M = {}


-- Use One-Dark for terraform files.

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.tf,*.tfvars,*.hcl",
    callback = function(args)
      require('onedark').setup{
        style = 'darker'
      }
      require('onedark').load()
    end,
    desc = "Use One-Dark theme",
})
vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*.tf",
    callback = function(args)
        require('plugins/colorscheme').SetupDefaultColorScheme()
    end,
    desc = "Use default colorscheme theme",
})


-- Format on save

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.tf", "*.tfvars"},
    callback = function(args)
        vim.lsp.buf.formatting_sync()
    end,
    desc = "Format terraform files",
})

-- File detection override

-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--     pattern = {"*.tf", "*.tfvars", "*.hcl"},
--     callback = function(args)
--       vim.api.nvim_command('set filetype=hcl')
--       -- vim.api.nvim_exec([[
--       --   set filetype=hcl
--       -- ]], false)
--     end,
--     desc = "set filetype to hcl for terraform highlights",
-- })

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.tfstate", "*.tfstate.backup"},
    callback = function(args)
      vim.api.nvim_command('set filetype=json')
      -- vim.api.nvim_exec([[
      --   set filetype=json
      -- ]], false)
    end,
    desc = "set filetype to json for terraform state and backup files",
})

M.config = {
  flags = { debounce_text_changes = 150 },
  filetypes = {"terraform", "tf", "hcl"}
}

return M
