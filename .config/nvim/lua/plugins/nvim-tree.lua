local g = vim.g
local cmd = vim.cmd
local map = vim.api.nvim_set_keymap

-- These additional options must be set BEFORE calling require'nvim-tree' or calling setup.
-- They are being migrated to the setup function bit by bit,
g.nvim_tree_refresh_wait = 500 -- 1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.

require('nvim-tree').setup {
  disable_netrw       = false, -- disables netrw
  hijack_netrw        = false, -- prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
  open_on_tab         = false, -- will open the tree when entering a new tab and the tree was previously open
  hijack_cursor       = false, -- when moving cursor in the tree, will position the cursor at the start of the file on the current line
  update_cwd          = false, -- will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
  git = {
    ignore = false,
  },
  create_in_closed_folder = false, -- true by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
  hijack_directories   = {
    enable = true, -- this option allows the cursor to be updated when entering a buffer
    auto_open = false,
  },
  diagnostics = {
    enable = false, -- will show lsp diagnostics in the signcolumn. See :help nvim_tree.diagnostics
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false, -- this option hides files and folders starting with a dot `.`
    custom = {}
  },
  view = {
    width = 35, -- 30 by default, can be width_in_columns or 'width_in_percent%'
    side = 'left',
  },
  renderer = {
    group_empty = true, -- compact folders that only contain a single folder into one node in the file tree
    highlight_opened_files = "icon", -- "none" by default, will enable folder and file icon highlight for opened files/directories.
    root_folder_modifier = ':~', -- This is the default. See :help filename-modifiers for more options
    root_folder_label = false, -- hide root folder
    add_trailing = false, -- append a trailing slash to folder names
    highlight_git = false, -- this will enable file highlight for git attributes (can be used without the icons).
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    -- List of filenames that gets highlighted with NvimTreeSpecialFile
    special_files = { 
      ['README.md'] = 1,
      ['Makefile'] = 1,
      ['MAKEFILE'] = 1,
    },
    icons = {
      padding = ' ', -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
      symlink_arrow = ' >> ', -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
      -- If 0, do not show the icons for one of 'git' 'folder' and 'files'
      -- 1 by default, notice that if 'files' is 1, it will only display
      -- if nvim-web-devicons is installed and on your runtimepath.
      -- if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
      -- but this will not work when you set indent_markers (because of UI conflict)
      show = {
        ['git'] = true,
        ['folder'] = true,
        ['file'] = true,
        ['folder_arrow'] = false,
      },
      glyphs = {
      --   -- default will show icon by default if no icon is provided
      --   -- default shows no icon by default
        ['default'] = '',
        ['symlink'] = '',
        ['git'] = {
          ['unstaged'] = "✗",
          ['staged'] = "✓",
          ['unmerged'] = "",
          ['renamed'] = "➜",
          ['untracked'] = "★",
          ['deleted'] = "",
          ['ignored'] = "◌"
        },
        ['folder']= {
          ['arrow_open'] = "⬎",
          ['arrow_closed'] = "⬏",
          ['default'] = "",
          ['open'] = "",
          ['empty'] = "",
          ['empty_open'] = "",
          ['symlink'] = "",
          ['symlink_open'] = "",
        }
      }
    }
  },
  actions = {
    -- use_system_clipboard = true,
    -- change_dir = {
    --   enable = true,
    --   global = false,
    --   restrict_above_cwd = false,
    -- },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  }

}

-- Automatically close the tab/vim when nvim-tree is the last window in the tab.
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*NvimTree_*",
    callback = function(args)
      -- Count leftover windows
      n_wins = 0
      for _ in pairs(vim.api.nvim_list_wins()) do n_wins = n_wins + 1 end

      if n_wins == 1 then
        vim.api.nvim_command('silent! quit')
      end
    end,
    desc = "Quit if Nvim-Tree is last window",
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*NvimTree_*",
    callback = function(args)
        vim.api.nvim_command('set cursorline')
    end,
    desc = "Set Cursorline for nvim tree",
})

