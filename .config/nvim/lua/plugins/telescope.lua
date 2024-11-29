return {
  {
    "princejoogie/dir-telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
  },
  -- {
  --   "nvim-telescope/telescope-dap.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim"
  --   },
  -- },

  -- -- patch of telescope-dap to support dap-nvim >0.8
  -- -- requires 
  -- -- see https://github.com/nvim-telescope/telescope-dap.nvim/pull/24
  -- {
  --   url = "https://github.com/cryptomilk/telescope-dap.nvim",
  --   branch = "asn-fix",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     'nvim-telescope/telescope-ui-select.nvim',
  --   },
  -- },
  -- {
  --   'nvim-telescope/telescope-ui-select.nvim',
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim"
  --   },
  -- },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    version = false,
    opts = {
      defaults = {
        scroll_strategy = "cycle",
        selection_strategy = "reset",
        layout_strategy = "flex",
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        layout_config = {
          horizontal = {
            width = 0.8,
            height = 0.8,
            preview_width = 0.6,
          },
          vertical = {
            height = 0.8,
            preview_height = 0.5,
          },
        },
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-v>"] = function(...)
              require("telescope.actions").select_vertical(...)
            end,
            ["<C-x>"] = function(...)
              require("telescope.actions").select_horizontal(...)
            end,
            ["<C-t>"] = function(...)
              require("telescope.actions").select_tab(...)
            end,
            ["<C-c>"] = function(...)
              require("telescope.actions").close(...)
            end,
            ["<C-u>"] = function(...)
              require("telescope.actions").preview_scrolling_up(...)
            end,
            ["<C-d>"] = function(...)
              require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-q>"] = function(...)
              require("telescope.actions").smart_send_to_qflist(...)
              require("telescope.actions").open_qflist(...)
            end,
            ["<Tab>"] = function(...)
              require("telescope.actions").toggle_selection(...)
            end,
          },
          n = {
            ["<CR>"] = function(...)
              require("telescope.actions").select_default(...)
              require("telescope.actions").center(...)
            end,
            ["<C-v>"] = function(...)
              require("telescope.actions").select_vertical(...)
            end,
            ["<C-x>"] = function(...)
              require("telescope.actions").select_horizontal(...)
            end,
            ["<C-t>"] = function(...)
              require("telescope.actions").select_tab(...)
            end,
            ["<Esc>"] = function(...)
              require("telescope.actions").close(...)
            end,
            ["j"] = function(...)
              require("telescope.actions").move_selection_next(...)
            end,
            ["k"] = function(...)
              require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-u>"] = function(...)
              require("telescope.actions").preview_scrolling_up(...)
            end,
            ["<C-d>"] = function(...)
              require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-q>"] = function(...)
              require("telescope.actions").send_to_qflist(...)
            end,
            ["<Tab>"] = function(...)
              require("telescope.actions").toggle_selection(...)
            end,
          },
        },
      },
      -- pickers = {
      --   git_commits = {
      --     previewer = {
      --       delta,
      --       previewers.git_commit_message.new {},
      --       previewers.git_commit_diff_as_was.new {},
      --     },
      --   },
      -- },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        },
        -- https://github.com/princejoogie/dir-telescope.nvim#with-telescope-extensions
        dir = {
          hidden = true, -- do not show hidden files
          respect_gitignore = true,
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension('fzf') -- Sorter using fzf algorithm
      -- telescope.load_extension('dap') -- Debugger Adapter Protocol
      -- telescope.load_extension("ui-select")
    end
  }
}
