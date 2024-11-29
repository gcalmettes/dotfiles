return {
  {'fatih/vim-go'}
}

-- -- Check https://mariocarrion.com/2024/05/20/neovim-migrating-to-lazy-and-go-nvim.html
-- return {
--   {
--     "ray-x/navigator.lua",
--     dependencies = {
--       "neovim/nvim-lspconfig",
--       "hrsh7th/nvim-cmp",
--       "nvim-treesitter/nvim-treesitter",
--       {
--         "ray-x/guihua.lua", 
--         run = "cd lua/fzy && make"
--       },
--       {
--         "ray-x/go.nvim",
--         event = {"CmdlineEnter"},
--         ft = {"go", "gomod"},
--         build = ':lua require("go.install").update_all_sync()'
--       },
--       {
--         "ray-x/lsp_signature.nvim", -- Show function signature when you type
--         event = "VeryLazy",
--         config = function()
--           require("lsp_signature").setup()
--         end
--       }
--     },
--     config = function()
--       require("go").setup()
--       require("navigator").setup({
--         lsp_signature_help = true, -- enable ray-x/lsp_signature
--         lsp = {format_on_save = true}
--       })
--     end
--   }
-- }
