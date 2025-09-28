return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "ravitemer/mcphub.nvim",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      {
        "echasnovski/mini.diff",
        config = function()
          local diff = require("mini.diff")
          diff.setup({
            -- Disabled by default
            source = diff.gen_source.none(),
          })
        end,
      },
    },
    config = function(_, opts)
      require("codecompanion").setup({
        strategies = {
            chat = {
              adapter = "openai",
              tools = {
                ["cmd_runner"] = {
                  opts = {
                    requires_approval = false,
                  },
                },
                ["insert_edit_into_file"] = {
                  opts = {
                    requires_approval = false,
                  },
                },
              },
            },
            inline = {
              adapter = "openai",
            },
          },
        adapters = {
          http = {
            openai = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                schema = {
                  model = {
                    -- default = "llama3.1",
                    default = "qwen2.5-coder-32b-instruct",
                  },
                },
                env = {
                  url = "https://api.scaleway.ai", -- optional: default value is ollama url http://127.0.0.1:11434
                  api_key = "cmd:echo $SCW_API_KEY", -- optional: if your endpoint is authenticated
                  chat_url = "/v1/chat/completions", -- optional: default value, override if different
                },
              })
            end,
          },
        },
        -- extensions = {
        --   mcphub = {
        --     callback = "mcphub.extensions.codecompanion",
        --     opts = {
        --       make_vars = true,
        --       make_slash_commands = true,
        --       show_result_in_chat = true
        --     }
        --   }
        -- }
      })
    end
  }
}

