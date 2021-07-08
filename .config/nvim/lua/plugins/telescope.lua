local utils = require('utils')
local M = {}

M.plugin = {
  'nvim-telescope/telescope.nvim',
  requires = {
    {'nvim-lua/popup.nvim'},
    {'nvim-lua/plenary.nvim'},

    -- Preview media files in Telescope
    {
      'nvim-telescope/telescope-media-files.nvim',
    },
    -- Intelligent prioritization from your editing history when selecting files.
    -- {
    --   'nvim-telescope/telescope-frecency.nvim',
    --   after = 'nvim-telescope/telescope.nvim',
    -- },
    -- FZF style sorter
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    },
  },
  config = function()
    require("plugins.telescope").config()
  end,
}

M.config = function()
  local _, telescope = pcall(require, "telescope")
  -- local actions = require "telescope.actions"
  local previewers = require "telescope.previewers"

  -- local k = vim.keymap
  -- local nnoremap = k.nnoremap

  local delta = previewers.new_termopen_previewer {
    get_command = function(entry)
      return {
        "git",
        "-c",
        "core.pager=delta",
        "-c",
        "delta.side-by-side=false",
        "diff",
        entry.value .. "^!",
      }
    end,
  }

  M.no_preview = function()
    return require("telescope.themes").get_dropdown {
      borderchars = {
        { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
      width = 0.8,
      previewer = false,
    }
  end

  telescope.setup {
  --   defaults = {
  --     file_previewer = previewers.vim_buffer_cat.new,
  --     grep_previewer = previewers.vim_buffer_vimgrep.new,
  --     qflist_previewer = previewers.vim_buffer_qflist.new,
  --     scroll_strategy = "cycle",
  --     selection_strategy = "reset",
  --     layout_strategy = "flex",
  --     borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  --     layout_defaults = {
  --       horizontal = {
  --         width_padding = 0.1,
  --         height_padding = 0.1,
  --         preview_width = 0.6,
  --       },
  --       vertical = {
  --         width_padding = 0.05,
  --         height_padding = 1,
  --         preview_height = 0.5,
  --       },
  --     },
  --     mappings = {
  --       i = {
  --         ["<C-j>"] = actions.move_selection_next,
  --         ["<C-k>"] = actions.move_selection_previous,

  --         ["<C-v>"] = actions.select_vertical,
  --         ["<C-x>"] = actions.select_horizontal,
  --         ["<C-t>"] = actions.select_tab,

  --         ["<C-c>"] = actions.close,
  --         ["<Esc>"] = actions.close,

  --         ["<C-u>"] = actions.preview_scrolling_up,
  --         ["<C-d>"] = actions.preview_scrolling_down,
  --         ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
  --         ["<Tab>"] = actions.toggle_selection,
  --         -- ["<C-r>"] = actions.refine_result,
  --       },
  --       n = {
  --         ["<CR>"] = actions.select_default + actions.center,
  --         ["<C-v>"] = actions.select_vertical,
  --         ["<C-x>"] = actions.select_horizontal,
  --         ["<C-t>"] = actions.select_tab,
  --         ["<Esc>"] = actions.close,

  --         ["j"] = actions.move_selection_next,
  --         ["k"] = actions.move_selection_previous,

  --         ["<C-u>"] = actions.preview_scrolling_up,
  --         ["<C-d>"] = actions.preview_scrolling_down,
  --         ["<C-q>"] = actions.send_to_qflist,
  --         ["<Tab>"] = actions.toggle_selection,
  --       },
  --     },
  --   },
    pickers = {
  --     find_files = {
  --       file_ignore_patterns = { "%.png", "%.jpg", "%.webp" },
  --     },
  --     lsp_code_actions = M.no_preview(),
  --     current_buffer_fuzzy_find = M.no_preview(),
      git_commits = {
        previewer = {
          delta,
          previewers.git_commit_message.new {},
          previewers.git_commit_diff_as_was.new {},
        },
      },
    },
    extensions = {
      fzf = {
        override_generic_sorter = true,
        override_file_sorter = true,
      },
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "mkv" },
        find_cmd = "rg",
      },
      -- frecency = {
      --   show_scores = false,
      --   show_unindexed = true,
      --   ignore_patterns = { "*.git/*", "*/tmp/*" },
      --   workspaces = {
      --     ["nvim"] = "/home/gcalmettes/.config/nvim",
      --   },
      -- },
    },
  }

  local builtin = require("telescope.builtin")

  pcall(telescope.load_extension, "fzf") -- superfast sorter
  pcall(telescope.load_extension, "media_files") -- media preview
  -- pcall(telescope.load_extension, "frecency") -- frecency

  M.frecency = function()
    -- telescope.extensions.frecency.frecency(M.no_preview())
  end

  M.grep_prompt = function()
    builtin.grep_string {
      shorten_path = true,
      search = vim.fn.input "Grep String > ",
      only_sort_text = true,
      use_regex = true,
    }
  end

  -- toggle telescope.nvim
  utils.map("n", "<leader>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>")
  utils.map("n", "<leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>")
  utils.map("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>")
  utils.map("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>")
  utils.map("n", "<leader>fl", "<CMD>lua require('telescope.builtin').file_browser()<CR>")
  utils.map("n", "<leader>fgc", "<CMD>lua require('telescope.builtin').git_commits()<CR>")

  utils.map("n", "<leader>fbb", "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
  -- utils.map("n", "<leader>fmf", "<CMD>lua require('plugins.telescope').frecency()<CR>")

  -- nnoremap { "<C-p>", builtin.find_files, { silent = true } }
  -- nnoremap { "<C-f>", M.grep_prompt, { silent = true } }
  -- nnoremap { "<Leader>fb", builtin.current_buffer_fuzzy_find, { silent = true } }
  -- nnoremap { "<Leader>ff", M.frecency, { silent = true } }
  -- nnoremap { "<Leader>fl", builtin.file_browser, { silent = true } }
  -- nnoremap { "<Leader>fg", builtin.live_grep, { silent = true } }
  -- nnoremap { "<Leader>fgc", builtin.git_commits, { silent = true } }
end

return M

--require('telescope').setup{
--  defaults = {
--    vimgrep_arguments = {
--      'rg',
--      '--color=never',
--      '--no-heading',
--      '--with-filename',
--      '--line-number',
--      '--column',
--      '--smart-case'
--    },
--    prompt_position = "bottom",
--    prompt_prefix = "> ",
--    selection_caret = "> ",
--    entry_prefix = "  ",
--    initial_mode = "insert",
--    selection_strategy = "reset",
--    sorting_strategy = "descending",
--    layout_strategy = "horizontal",
--    layout_defaults = {
--      horizontal = {
--        mirror = false,
--      },
--      vertical = {
--        mirror = false,
--      },
--    },
--    file_sorter =  require('telescope.sorters').get_fuzzy_file,
--    file_ignore_patterns = {},
--    generic_sorter =  require('telescope.sorters').get_generic_fuzzy_sorter,
--    shorten_path = true,
--    winblend = 0,
--    width = 0.75,
--    preview_cutoff = 120,
--    results_height = 1,
--    results_width = 0.8,
--    border = {},
--    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
--    color_devicons = true,
--    use_less = true,
--    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
--    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
--    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
--    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
--
--    -- Developer configurations: Not meant for general override
--    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker
--  }
--}

--require('telescope').load_extension('fzf')
--require('telescope').load_extension('gh')

--require('telescope').setup {
--    find_command = {
--        'rg', '--no-heading', '--with-filename', '--line-number', '--column',
--        '--smart-case'
--    },
--    use_less = true,
--    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
--    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
--    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
--    extensions = {
--        arecibo = {
--            ["selected_engine"] = 'google',
--            ["url_open_command"] = 'open',
--            ["show_http_headers"] = false,
--            ["show_domain_icons"] = false
--        },
--        fzf = {
--            override_generic_sorter = false,
--            override_file_sorter = true,
--            case_mode = "smart_case"
--        }
--    }
-- }




-- utils.map("n", "<leader>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>")
-- utils.map("n", "<leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>")
-- utils.map("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>")
-- utils.map("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>")
