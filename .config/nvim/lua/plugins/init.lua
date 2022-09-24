
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end

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

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp")
    end
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

  -- NerdTree
  {
    'kyazdani42/nvim-tree.lua',
    requires = {
      {'kyazdani42/nvim-web-devicons'},
      config = function()
        -- require("plugins.nvim-tree").setup()
        require("plugins.nvim-tree")
      end
    },
  },

}

packer.startup(function(use)
  for _, v in pairs(plugins) do
    use(v)
  end
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('plugins.colorscheme')
require('plugins.nvim-tree')

