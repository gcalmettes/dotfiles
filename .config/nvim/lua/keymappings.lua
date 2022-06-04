local map = vim.api.nvim_set_keymap

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


