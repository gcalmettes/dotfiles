local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end
--
--
-- vim.cmd [[packadd packer.nvim]]

-- local packer_ok, packer = pcall(require, "packer")
-- if not packer_ok then
--   return
-- end

packer.init {
  ensure_dependencies = true,
  -- compile_path = vim.fn.stdpath('data')..'/site/pack/loader/start/packer.nvim/plugin/packer_compiled.vim',
  git = {
    clone_timeout = 300, -- 5 minutes, I have horrible internet
  },
  -- display = {
  --   open_fn = function()
      -- return require("packer.util").float {
      --   border = {
      --     -- fancy border
      --     { "🭽", "FloatBorder" },
      --     { "▔", "FloatBorder" },
      --     { "🭾", "FloatBorder" },
      --     { "▕", "FloatBorder" },
      --     { "🭿", "FloatBorder" },
      --     { "▁", "FloatBorder" },
      --     { "🭼", "FloatBorder" },
      --     { "▏", "FloatBorder" },

      --     -- padding border
      --     -- {"▄", "Bordaa"},
      --     -- {"▄", "Bordaa"},
      --     -- {"▄", "Bordaa"},
      --     -- {"█", "Bordaa"},
      --     -- {"▀", "Bordaa"},
      --     -- {"▀", "Bordaa"},
      --     -- {"▀", "Bordaa"},
      --     -- {"█", "Bordaa"}
      --   } 
      -- }
    -- end,
  -- },
}

local plugins = {
  -- Packer can manage itself
  {'wbthomason/packer.nvim'},

  -- Colorscheme
  {'mhartington/oceanic-next'},

  -- Provide icons for plugins
  {'kyazdani42/nvim-web-devicons'},

  -- Fuzzy finder
  require("plugins.telescope").plugin,

  -- NerdTree
  {
    'kyazdani42/nvim-tree.lua',
    requires = {
      {'kyazdani42/nvim-web-devicons'},
    },
  },

  -- LSP and completion
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/nvim-compe'},


  {"tpope/vim-commentary"},

  -- Brackets and matching pairs utils
  {'9mm/vim-closer'},
  {
    'andymass/vim-matchup',
    event = 'VimEnter'
  },

  -- languages modules for tree-sitter
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  },

  {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
    end
  },

}

packer.startup(function(use)
  for _, v in pairs(plugins) do
    use(v)
  end
end)

require('plugins.colorscheme')
require('plugins.nvim-tree')


