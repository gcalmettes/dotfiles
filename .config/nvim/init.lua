local cmd = vim.cmd
local g = vim.g

cmd [[packadd packer.nvim]]

-- Map leader to comma
g.mapleader = ','

-- Sensible defaults
require('settings')

-- Key mappings
require('keymappings')

-- Plugins
require('plugins')

