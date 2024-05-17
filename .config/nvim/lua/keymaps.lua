-------------------------------------------------------------------------------
--
-- Key mappings
--
-------------------------------------------------------------------------------

-- local map = vim.keymap.set
local map = require("utils").Keymap

----------------
-- GLOBAL
----------------

map('', '<leader>c', '"+y', {
  desc = "Copy to clipboard in normal, visual, select and operator modes",
})

map('i', '<C-u>', '<C-g>u<C-u>', {
  desc = "Make <C-u> undo-friendly",
})

map('i', '<C-w>', '<C-g>u<C-w>', {
  desc = "Make <C-w> undo-friendly",
})

map('n', '<leader>o', 'm`o<Esc>``', {
  desc = "Insert a newline in normal mode",
})

map('n', '<Esc>', '<cmd>noh<CR><Esc>', {
  desc = "Clear highlighting on escape in normal mode",
})
map('n', '<Esc>^[', '<Esc>^[', {
  desc = "Mapping to the escape key since Vim internally uses escape to represent special keys",
})

map('n', '<C-l>', '<cmd>noh<CR>', {
  desc = "Clear highlights",
})

map('n', '<leader>d', '"_d', {
  desc = "Delete and send to the black hole register",
})

-- Somehow, it's already on
--map('n', '<leader>nn', ':NvimTreeToggle<CR>`')


----------------
-- PLUGINS
----------------

--
-- telescope
--

map("n", "<leader>ff", "<CMD>lua require('telescope.builtin').find_files()<CR>", {
  desc = "Find files",
})
map("n", "<leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", {
  desc = "Find by grep in current directory",
})
map("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>", {
  desc = "Find in opened buffers",
})
map("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", {
  desc = "Toggle Help",
})
map("n", "<leader>fl", "<CMD>lua require('telescope.builtin').file_browser()<CR>", {
  desc = "Browse files",
})
map("n", "<leader>fgc", "<CMD>lua require('telescope.builtin').git_commits()<CR>", {
  desc = "Find git commits",
})

map("n", "<leader>fbb", "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", {
  desc = "Fuzzy search in current buffer",
})

--
-- telescope-dir
--
map("n", "<leader>fgd", "<CMD>lua require('telescope').extensions.dir.live_grep()<CR>", {
  desc = "Find by grep in specified directory",
})
map("n", "<leader>ffd", "<CMD>lua require('telescope').extensions.dir.find_files()<CR>", {
  desc = "Find by grep in specified directory",
})

--
-- nvim-tree
--

map('n', '<leader>nn', '<CMD>lua require("nvim-tree.api").tree.toggle()<CR>', {
  desc = "Toggle Nvim-Tree",
})

map('n', '<leader>r', '<CMD>lua require("nvim-tree.api").tree.refresh()<CR>', {
  desc = "Refresh Nvim-Tree",
})

map('n', '<leader>n', '<CMD>lua require("nvim-tree.api").tree.find_file(true)<CR>', {
  desc = "Nvim-Tree find_file",
})

--
-- git diffview
--

map('n', '<leader>dvo', '<CMD>lua require("diffview").open({})<CR>', {
  desc = "Toggle Git Diff View open",
})
map('n', '<leader>dvc', '<CMD>lua require("diffview").close()<CR>', {
  desc = "Close current Git Diff View",
})
map('n', '<leader>dvh', '<CMD>lua require("diffview").file_history({})<CR>', {
  desc = "Git Diff view history of current file",
})

--
-- trouble
--
map("n", "<leader>xx", "<cmd>Trouble<cr>")
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
map("n", "gR", "<cmd>Trouble lsp_references<cr>")
