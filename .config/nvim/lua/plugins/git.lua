-- local cb = require('diffview.config)'.diffview_callback

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,

      current_line_blame = false, -- whether to show blame for current line
      current_line_blame_opts = {
        virt_text = true,
        virt_text_post = 'eol',
        delay = 1000,
      },
      current_line_blame_formatter_opts = {
        relative_time = false
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm = {
        enable = false
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "<leader>hn", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, desc = "Next git hunk" })
        map("n", "<leader>hp", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, desc = "Previous git hunk" })
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo staging hunk" })
        map({ "n", "v" }, "<leader>hr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
        map("n", "<leader>hb", gs.blame_line, { desc = "Blame line" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hP", gs.preview_hunk, { desc = "Preview hunk" })
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end
  },
  {
    'sindrets/diffview.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      diff_binaries = false,    -- Show diffs for binaries
      enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
      use_icons = true,         -- Requires nvim-web-devicons
      icons = {                 -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
      },
      file_panel = {
        win_config = {
          position = "left",            -- One of 'left', 'right', 'top', 'bottom'
          width = 35,                   -- Only applies when position is 'left' or 'right'
          height = 10,                  -- Only applies when position is 'top' or 'bottom'
        },            -- One of 'left', 'right', 'top', 'bottom'
        listing_style = "tree",       -- One of 'list' or 'tree'
        tree_options = {              -- Only applies when listing_style is 'tree'
          flatten_dirs = true,
          folder_statuses = "always"  -- One of 'never', 'only_folded' or 'always'.
        }
      },
      file_history_panel = {
        win_config = {
          position = "bottom",
          width = 35,
          height = 16,
        },
        log_options = {
          git = {
            single_file = {
              max_count = 512,
              follow = true,
            },
          },
          multi_file = {
            max_count = 128,
            -- follow = false   -- `follow` only applies to single-file history
          },
        },
      },
      default_args = {    -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      key_bindings = {
        disable_defaults = false,                   -- Disable the default key bindings
      },
    },
    config = function(_, opts)
      require('diffview').setup(opts)
    end
  },
}
