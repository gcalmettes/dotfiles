-------------------------------------------------------------------------------
--
-- Globals and options
--
-------------------------------------------------------------------------------
local o = vim.opt
local g = vim.g
local wo = vim.wo

local indent = 2

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
wo.signcolumn = "yes"

g.netrw_banner        = 0  -- remove the netrw banner
g.netrw_liststyle     = 3  -- tree style listing of directories
g.netrw_browse_split  = 0  -- open the file in the main window
g.netrw_altv          = 1  -- tree style listing of directories

o.autowrite           = true  -- auto write buffer when it's not focused
o.clipboard           = "unnamedplus"  -- Yank and paste with the system clipboard
o.cmdheight           = 1  -- Only one line for command line
-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
o.completeopt         = {'menu', 'menuone', 'noinsert', 'noselect'}  -- Completion options (for nvim-compe)
o.encoding            = "UTF-8" -- set encoding
o.expandtab           = true  -- Use spaces instead of tabs
o.hidden              = true  -- Enable background buffers
o.ignorecase          = true  -- Ignore case
o.joinspaces          = false -- No double spaces with join
o.list                = true  -- Show some invisible characters
o.mouse               = "nvi" -- enable mouse support in normal, insert, and visual mode
o.number              = true  -- Show line numbers
o.updatetime          = 300  -- 300ms of no cursor movement to trigger CursorHold
o.relativenumber      = false -- Relative line numbers
o.scrolloff           = 4   -- Lines of context
o.sidescroll          = 4   -- make scrolling better
o.shiftround          = true  -- Round indent
o.shiftwidth          = indent  -- Size of an indent
o.shortmess           = vim.opt.shortmess + "c" -- Avoid showing extra messages when using completion
o.sidescrolloff       = 8 -- Columns of context
o.smartcase           = true  -- Do not ignore case with capitals
o.smarttab            = false  -- make tab behaviour smarte
o.smartindent         = false  -- Insert indents automatically. We are using treesitter for that
o.splitbelow          = true  -- Put new windows below current
o.splitkeep           = "screen"  -- stabilize split
o.splitright          = true  -- Put new windows right of current
-- o.swapfile            = false -- disable swapfile
o.tabstop             = indent  -- Number of spaces tabs count for
o.termguicolors       = true  -- true colours for better experience
o.wildmode            = {'list', 'longest'} -- Command-line completion mode
o.wrap                = false -- Disable line wrap
