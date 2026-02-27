return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
      },
      {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
          keymap = {
            preset = "enter",
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
          },
          cmdline = { sources = { "cmdline" } },
          sources = {
            default = { "lsp", "path", "buffer", "codecompanion" },
          },
        },
      },
    },
    opts = {
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "DEBUG", -- or "TRACE"
      },
    },
    config = function(_, opts)
      require("codecompanion").setup({
        interactions = {
            chat = {
              adapter = "openai",
              keymaps = {
                send = {
                  modes = { n = "<C-s>", i = "<C-s>" },
                  opts = {},
                },
                close = {
                  modes = { n = "<C-c>", i = "<C-c>" },
                  opts = {},
                },
                -- Add further custom keymaps here
              },
            },
            inline = {
              adapter = "openai",
              keymaps = {
                accept_change = {
                  modes = { n = "gda" }, -- Remember this as DiffAccept
                },
                reject_change = {
                  modes = { n = "gdr" }, -- Remember this as DiffReject
                },
                always_accept = {
                  modes = { n = "gdy" }, -- Remember this as DiffYolo
                },
              },
            },
            cmd = {
              adapter = "openai",
            }
          },
        adapters = {
          http = {
            openai = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                schema = {
                  model = {
                    default = "qwen3-235b-a22b-instruct-2507",
                  },
                },
                env = {
                  url = "https://api.scaleway.ai", -- optional: default value is ollama url http://127.0.0.1:11434
                  api_key = "SCW_API_KEY", -- optional: if your endpoint is authenticated
                  chat_url = "/v1/chat/completions", -- optional: default value, override if different
                },
              })
            end,
          },
        },
      })
    end
  }
}

