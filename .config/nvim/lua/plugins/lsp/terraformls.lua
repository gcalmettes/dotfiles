local M = {}

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.tf",
    callback = function(args)
        vim.lsp.buf.formatting_sync()
    end,
    desc = "Format terraform files",
})


-- vim.filetype.add {
--   extension = {
--     tf = 'hcl',
--   }
-- }

vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.tf,*.tfvars,*.hcl",
    callback = function(args)
      vim.api.nvim_exec([[
        set filetype=hcl
      ]], false)
    end,
    desc = "set filetype to hcl for terraform highlights",
})


vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
    pattern = "*.tfstate,*.tfstate.backup",
    callback = function(args)
      vim.api.nvim_exec([[
        set filetype=json
      ]], false)
    end,
    desc = "set filetype to hcl for terraform highlights",
})

M.config = {
  flags = { debounce_text_changes = 150 },
  filetypes = {"terraform", "tf", "hcl"}
}

return M
