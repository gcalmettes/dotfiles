local M = {}

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.tf",
    callback = function(args)
        vim.lsp.buf.formatting_sync()
    end,
    desc = "Format terraform files",
})

M.config = {
  flags = { debounce_text_changes = 150 },
  filetypes = {"terraform", "tf", "hcl"}
}

return M
