local cmd = vim.cmd
local opt = vim.opt
local indent = 2
local g = vim.g

g.netrw_banner = 0    -- remove the netrw banner
g.netrw_liststyle = 3 -- tree style listing of directories
-- g.netrw_browse_split = 4 -- open the file in the main window
g.netrw_altv = 1 -- tree style listing of directories

opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options (for nvim-compe)
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.relativenumber = false          -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = indent                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = indent                     -- Number of spaces tabs count for
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.cmdheight = 1                   -- Only one line for command line
opt.clipboard = "unnamedplus"       -- Yank and paste with the system clipboard

-- Highlight on yank
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

