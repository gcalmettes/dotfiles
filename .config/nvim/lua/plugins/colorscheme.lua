return {
    {
        "mhartington/oceanic-next",
        opts = {},
        config = function(_, opts)
          -- True color support
          if vim.fn.has("termguicolors") == 1  then
              vim.opt.termguicolors = true
          end
          require("utils").SetupOceanicNext()
        end
    },
    {
      'navarasu/onedark.nvim'
    },
}
