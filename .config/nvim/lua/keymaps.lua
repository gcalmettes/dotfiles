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

-- FOLDs mapping (see https://gist.github.com/lestoni/8c74da455cce3d36eb68)
-- zR open all folds
-- zM close all open folds
-- za toggles the fold at the cursor

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


--
-- nvim-dap
--
map("n", "<leader>d", function() require("dap").continue() end)
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end)
map("n", "<leader>dB", function() require("dap").set_breakpoint() end)
map("n", "<leader>dC", function() require("dap").clear_breakpoints() end)
map("n", "<leader>de", function() require("dap").run_to_cursor() end)
map("n", "<leader>di", function() require("dap").step_into() end)
map("n", "<leader>do", function() require("dap").step_out() end)
map("n", "<leader>dn", function() require("dap").step_over() end)
map("n", "<leader>dr", function() require("dap").restart() end)
map("n", "<leader>dp", function() require("dap").pause() end)
map("n", "<leader>dt", function() require("dap").terminate() end)

-- Toggle the repl
map("n", "<leader>du", function() require("dap").repl.toggle() end)
-- Toggle dapui full layout
map("n", "<leader>dui", function() require("dapui").toggle() end)

-- Visually see the dapui debugging widgets independently
local floating_settings = {
    width = 120, height = 40,
    enter = true, position = "center"
}
map("n", "<Leader>ds", function() require("dapui").float_element("scopes", floating_settings) end)
map("n", "<Leader>dl", function() require("dapui").float_element("breakpoints", floating_settings) end)
map("n", "<Leader>df", function() require("dapui").float_element("stacks", floating_settings) end)
map("n", "<Leader>dw", function() require("dapui").float_element("watches", floating_settings) end)



map("n", "<Leader>rr", function() 
  local input_port
  vim.ui.input(
    {prompt='Which port do you want to connect the dap? '},
    function(str)
      input_port = str

      local dap = require('dap')

      dap.adapters.delve = {
        type = 'server',
        host = '127.0.0.1',
        port = input_port
      }
      require("dap").continue()
    end)
end)




-- vim.keymap.set("n", "<Leader>df", function()
-- 	local widgets = require("dap.ui.widgets")
-- 	widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set("n", "<Leader>ds", function()
-- 	local widgets = require("dap.ui.widgets")
--   -- widgets.scopes
-- 	widgets.centered_float(widgets.scopes)
-- end)



-- vim.keymap.set("n", "<Leader>dk", function()
-- 	require("dap").continue()
-- end)
-- vim.keymap.set("n", "<leader>ddt", function()
-- 	require("dap").step_over()
-- end)
-- vim.keymap.set("n", "<leader>do", function()
-- 	require("dap").step_into()
-- end)
-- vim.keymap.set("n", "<leader>di", function()
-- 	require("dap").step_out()
-- end)
-- vim.keymap.set("n", "<Leader>b", function()
-- 	require("dap").toggle_breakpoint()
-- end)
-- vim.keymap.set("n", "<Leader>B", function()
-- 	require("dap").set_breakpoint()
-- end)
-- vim.keymap.set("n", "<Leader>lp", function()
-- 	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
-- end)
-- vim.keymap.set("n", "<Leader>dr", function()
-- 	require("dap").repl.open()
-- end)
-- vim.keymap.set("n", "<Leader>dl", function()
-- 	require("dap").run_last()
-- end)
-- vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
-- 	require("dap.ui.widgets").hover(nil, { border = "none" })
-- end)
-- vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
-- 	require("dap.ui.widgets").preview()
-- end)
-- vim.keymap.set("n", "<Leader>df", function()
-- 	local widgets = require("dap.ui.widgets")
-- 	widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set("n", "<Leader>ds", function()
-- 	local widgets = require("dap.ui.widgets")
-- 	widgets.centered_float(widgets.scopes)
-- end)
