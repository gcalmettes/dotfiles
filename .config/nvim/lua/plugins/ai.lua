return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
    },
    -- config = true
    config = function(_, opts)
      print("I HAVEW RUN")
      require("codecompanion").setup({
        strategies = {
            chat = {
              adapter = "openai",
            },
            inline = {
              adapter = "openai",
            },
          },
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = {
                  -- default = "llama3.1",
                  default = "qwen2.5",
                },
              },
              env = {
                url = "http://localhost:8004", -- optional: default value is ollama url http://127.0.0.1:11434
                api_key = "1111-11111", -- optional: if your endpoint is authenticated
                chat_url = "/v1/chat/completions", -- optional: default value, override if different
              },
            })
          end,
        },
      })
    end
  }
}

