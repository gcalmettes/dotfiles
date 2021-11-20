utils = require('utils')

utils.map('', '<leader>c', '"+y')       -- Copy to clipboard in normal, visual, select and operator modes
utils.map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
utils.map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly

-- <Tab> to navigate the completion menu
--map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
--map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

utils.map('n', '<leader>o', 'm`o<Esc>``')  -- Insert a newline in normal mode

-- Clear highlighting on escape in normal mode.
-- The second line is needed for mapping to the escape key since Vim internally uses escape to represent special keys.
utils.map('n', '<Esc>', '<cmd>noh<CR><Esc>')
utils.map('n', '<Esc>^[', '<Esc>^[')
-- Other syntax possible
utils.map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights

-- Somehow, it's already on
--utils.map('n', '<leader>nn', ':NvimTreeToggle<CR>`')  -- Insert a newline in normal mode


