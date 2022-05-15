local g = vim.g
local cmd = vim.cmd
utils = require('utils')



-- These additional options must be set BEFORE calling require'nvim-tree' or calling setup.
-- They are being migrated to the setup function bit by bit,
g.nvim_tree_git_hl = 0 -- this will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_group_empty = 1 -- compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_icon_padding = ' ' -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
g.nvim_tree_symlink_arrow = ' >> ' -- defaults to ' ➛ '. used as a separator between symlinks' source and target.
-- g.nvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
g.nvim_tree_create_in_closed_folder = 0 -- 1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
g.nvim_tree_refresh_wait = 500 -- 1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.



-- List of filenames that gets highlighted with NvimTreeSpecialFile
g.nvim_tree_special_files = { 
  ['README.md'] = 1,
  ['Makefile'] = 1,
  ['MAKEFILE'] = 1,
}

-- If 0, do not show the icons for one of 'git' 'folder' and 'files'
-- 1 by default, notice that if 'files' is 1, it will only display
-- if nvim-web-devicons is installed and on your runtimepath.
-- if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
-- but this will not work when you set indent_markers (because of UI conflict)
g.nvim_tree_show_icons = {
  ['git'] = 1,
  ['folders'] = 1,
  ['files'] = 1,
  ['folder_arrows'] = 0,
}

-- default will show icon by default if no icon is provided
-- default shows no icon by default
g.nvim_tree_icons = {
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



require('nvim-tree').setup {
  disable_netrw       = false, -- disables netrw
  hijack_netrw        = false, -- prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
  open_on_setup       = false, -- opens the tree when typing `vim $DIR` or `vim`
  ignore_ft_on_setup  = {},
  open_on_tab         = false, -- will open the tree when entering a new tab and the tree was previously open
  hijack_cursor       = false, -- when moving cursor in the tree, will position the cursor at the start of the file on the current line
  update_cwd          = false, -- will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
  git = {
    ignore = false,
  },
  update_to_buf_dir   = {
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
    width = 40, -- 30 by default, can be width_in_columns or 'width_in_percent%'
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false, -- will resize the tree to its saved width when opening a file
    mappings = {
      custom_only = false,
      list = {}
    }
  },
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
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


--utils.map('n', '<leader>nn', ':NvimTreeToggle<CR>')  -- Insert a newline in normal mode
utils.map('n', '<leader>nn', '<CMD>lua require("nvim-tree").toggle()<CR>')

utils.map('n', '<leader>r', '<CMD>lua require("nvim-tree").refresh()<CR>')
utils.map('n', '<leader>n', '<CMD>lua require("nvim-tree").find_file(true)<CR>')


-- NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them
-- nnoremap <C-n> :NvimTreeToggle<CR>
-- nnoremap <leader>r :NvimTreeRefresh<CR>
-- nnoremap <leader>n :NvimTreeFindFile<CR>

--
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


