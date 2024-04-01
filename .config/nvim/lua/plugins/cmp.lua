return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function()
      local map = vim.keymap.set
      local cmp = require("cmp")

      return {
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        window = {
          documentation = cmp.config.window.bordered {
            border = {
              "┌", "─", "┐", "│", "┘", "─", "└", "│",
            }
          },
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = "vsnip" },
          { name = "path" },
          { name = "buffer", keyword_length = 8 },
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item { cmp.SelectBehavior.Select },
          ["<S-Tab>"] = cmp.mapping.select_prev_item { cmp.SelectBehavior.Select },
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        })
      }
    end
  }
}
