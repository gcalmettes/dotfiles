local g = vim.g
local cmd = vim.cmd
utils = require('utils')

g.nvim_tree_icons = {
  ['folder']= {
    ['arrow_open'] = "⬎",
    ['arrow_closed'] = "⬏",
  },
}

g.nvim_tree_side = 'left'
g.nvim_tree_width = 40 -- 30 by default, can be width_in_columns or 'width_in_percent%'
g.nvim_tree_gitignore = 0
g.nvim_tree_auto_open = 1 -- opens the tree when typing `vim $DIR` or `vim`
g.nvim_tree_auto_close = 1 -- closes the tree when it's the last window
g.nvim_tree_quit_on_open = 0 -- closes the tree when you open a file
g.nvim_tree_follow = 1 -- this option allows the cursor to be updated when entering a buffer
g.nvim_tree_indent_markers = 1 -- this option shows indent markers when folders are open
g.nvim_tree_hide_dotfiles = 0 -- this option hides files and folders starting with a dot `.`
g.nvim_tree_git_hl = 0 -- will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 1 -- will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
g.nvim_tree_tab_open = 0 -- will open the tree when entering a new tab and the tree was previously open
g.nvim_tree_auto_resize = 0 -- will resize the tree to its saved width when opening a file
g.nvim_tree_disable_netrw = 0 -- disables netrw
g.nvim_tree_hijack_netrw = 0 -- prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_group_empty = 1 -- compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_lsp_diagnostics = 0 -- will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
g.nvim_tree_disable_window_picker = 0 -- will disable the window picker.
g.nvim_tree_hijack_cursor = 0 -- when moving cursor in the tree, will position the cursor at the start of the file on the current line
g.nvim_tree_icon_padding = ' ' -- used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
g.nvim_tree_update_cwd = 0 -- will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.

--utils.map('n', '<leader>nn', ':NvimTreeToggle<CR>')  -- Insert a newline in normal mode
utils.map('n', '<leader>nn', '<CMD>lua require("nvim-tree").toggle()<CR>')

-- Highlight current opened file in tree and hide cursor
-- modified from https://github.com/kyazdani42/nvim-tree.lua/issues/198#issuecomment-786616625
-- vim.api.nvim_exec([[
--   augroup HideCursor
--     au!
--     au WinLeave,FileType NvimTree set guicursor=n-v-c-sm:block,i-ci-ve:ver2u,r-cr-o:hor20,
--     au WinEnter,FileType NvimTree set guicursor=n-c-v:block-Cursor/Cursor-blinkon0,
--   augroup END
--   au FileType NvimTree hi Cursor blend=100
--   " Highlight current file
--   autocmd BufEnter NvimTree set cursorline
-- ]], false)


vim.api.nvim_exec([[
  au FileType NvimTree hi Cursor blend=100
  " Highlight current file
  autocmd BufEnter NvimTree set cursorline
]], false)
