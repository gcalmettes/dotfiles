local utils = require('utils')
local lsp = require('lspconfig')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()

require 'lspconfig'.pyright.setup {}

-- root_dir is where the LSP server will start: here at the project root otherwise in current folder
lsp.pyls.setup {root_dir = lsp.util.root_pattern('.git', fn.getcwd())}
utils.map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
utils.map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
utils.map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
utils.map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
utils.map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
utils.map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
utils.map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
utils.map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
utils.map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
