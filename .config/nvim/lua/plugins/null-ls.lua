
require("null-ls").setup({
    sources = {
        -- vale (need https://github.com/errata-ai/vale to be installed)
        require("null-ls").builtins.diagnostics.vale,
    },
})
