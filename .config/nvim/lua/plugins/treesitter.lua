return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "hcl",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "markdown",
        "latex",
        "lua",
        "python",
        "query",
        "regex",
        "rst",
        "rust",
        "scss",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "yaml"
      },

      highlight = { enable = true },
      indent = { enable = true },
      matchup = { enable = true },
      -- require https://github.com/windwp/nvim-ts-autotag
      autotag = { enable = true },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },

    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  }
}
