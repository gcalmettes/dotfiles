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
    pickers = {
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
    },
  }

  local builtin = require("telescope.builtin")

  pcall(telescope.load_extension, "fzf") -- superfast sorter
  pcall(telescope.load_extension, "media_files") -- media preview

  M.grep_prompt = function()
    builtin.grep_string {
      shorten_path = true,
      search = vim.fn.input "Grep String > ",
      only_sort_text = true,
      use_regex = true,
    }
  end

end

return M
