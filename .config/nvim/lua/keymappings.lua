local map = vim.api.nvim_set_keymap

----------------
-- GLOBAL
----------------

map('', '<leader>c', '"+y', {
  desc = "Copy to clipboard in normal, visual, select and operator modes",
  noremap = true,
  silent = true,
})

map('i', '<C-u>', '<C-g>u<C-u>', {
  desc = "Make <C-u> undo-friendly",
  noremap = true,
  silent = true,
})

map('i', '<C-w>', '<C-g>u<C-w>', {
  desc = "Make <C-w> undo-friendly",
  noremap = true,
  silent = true,
})

map('n', '<leader>o', 'm`o<Esc>``', {
  desc = "Insert a newline in normal mode",
  noremap = true,
  silent = true,
})

map('n', '<Esc>', '<cmd>noh<CR><Esc>', {
  desc = "Clear highlighting on escape in normal mode",
  noremap = true,
  silent = true,
})
map('n', '<Esc>^[', '<Esc>^[', {
  desc = "Mapping to the escape key since Vim internally uses escape to represent special keys",
  noremap = true,
  silent = true,
})

map('n', '<C-l>', '<cmd>noh<CR>', {
  desc = "Clear highlights",
  noremap = true,
  silent = true,
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
  noremap = true,
  silent = true,
})
map("n", "<leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", {
  desc = "Find by grep in current directory",
  noremap = true,
  silent = true,
})
map("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>", {
  desc = "Find in opened buffers",
  noremap = true,
  silent = true,
})
map("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", {
  desc = "Toggle Help",
  noremap = true,
  silent = true,
})
map("n", "<leader>fl", "<CMD>lua require('telescope.builtin').file_browser()<CR>", {
  desc = "Browse files",
  noremap = true,
  silent = true,
})
map("n", "<leader>fgc", "<CMD>lua require('telescope.builtin').git_commits()<CR>", {
  desc = "Find git commits",
  noremap = true,
  silent = true,
})

map("n", "<leader>fbb", "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", {
  desc = "Fuzzy search in current buffer",
  noremap = true,
  silent = true,
})


--
-- nvim-tree
--

map('n', '<leader>nn', '<CMD>lua require("nvim-tree").toggle()<CR>', {
  desc = "Toggle Nvim-Tree",
  noremap = true,
  silent = true,
})

map('n', '<leader>r', '<CMD>lua require("nvim-tree").refresh()<CR>', {
  desc = "Refresh Nvim-Tree",
  noremap = true,
  silent = true,
})

map('n', '<leader>n', '<CMD>lua require("nvim-tree").find_file(true)<CR>', {
  desc = "Nvim-Tree find_file",
  noremap = true,
  silent = true,
})


--
-- git diffview
--

map('n', '<leader>dvo', '<CMD>lua require("diffview").open({})<CR>', {
  desc = "Toggle Git Diff View open",
  noremap = true,
  silent = true,
})
map('n', '<leader>dvc', '<CMD>lua require("diffview").close()<CR>', {
  desc = "Close current Git Diff View",
  noremap = true,
  silent = true,
})
