return {
    {
        "mhartington/oceanic-next",
        opts = {},
        config = function(_, opts)
          require("utils").SetupOceanicNext()
        end
    },
    {
      'navarasu/onedark.nvim'
    },
}
