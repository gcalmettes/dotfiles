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

  -- languages modules for tree-sitter
  require("plugins.treesitter").plugin,

  -- NerdTree
  {
    'kyazdani42/nvim-tree.lua',
    requires = {
      {'kyazdani42/nvim-web-devicons'},
      config = function()
        -- require("plugins.nvim-tree").setup()
        require("plugins.nvim-tree")
      end,
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end,
  },
  {'simrat39/rust-tools.nvim'},

  -- Completion
  {
    "hrsh7th/nvim-compe",
    config = function()
      require("plugins.compe")
    end
  },

  {"tpope/vim-commentary"},

  -- Brackets and matching pairs utils
  {
    "windwp/nvim-autopairs",
    config = function()
     require("plugins.autopairs")
    end
  },
  -- {'andymass/vim-matchup'},
  {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    event = "BufEnter", -- don't need this on scratch buffer
    config = function()
      require('plugins.gitsigns')
      -- require('plugins.gitsigns').setup()
    end
  },

  {
    'sindrets/diffview.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('plugins.gitdiffview')
    end
  },

  -- null-ls (LSP like for non-LSP sources, so pure Lua)
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require("plugins.null-ls")
    end
  },

  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
}

packer.startup(function(use)
  for _, v in pairs(plugins) do
    use(v)
  end
end)
-- packer.startup(function(use)
--   for _, v in pairs(plugins) do
--     use(v)
--   end
-- end)

require('plugins.colorscheme')
require('plugins.nvim-tree')

