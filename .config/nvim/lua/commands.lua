-------------------------------------------------------------------------------
--
-- General
--
-------------------------------------------------------------------------------

-- Add transparency support for NeoVim
vim.api.nvim_command('au VimEnter * hi Normal guibg=NONE ctermbg=NONE')
vim.api.nvim_command('au VimEnter * hi LineNr guibg=NONE ctermbg=NONE')
vim.api.nvim_command('au VimEnter * hi SignColumn guibg=NONE ctermbg=NONE')
vim.api.nvim_command('au VimEnter * hi EndOfBuffer guibg=NONE ctermbg=NONE')

-- highlight yanked text
vim.api.nvim_create_autocmd(
  'TextYankPost',
  {
    pattern = '*',
    command = 'silent! lua vim.highlight.on_yank({ timeout = 500 })'
  }
)

-- jump to last edit position on opening file
vim.api.nvim_create_autocmd(
  'BufReadPost',
  {
    pattern = '*',
    callback = function(ev)
      if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
        -- except for in git commit messages
        -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
        if not vim.fn.expand('%:p'):find('.git', 1, true) then
          vim.cmd('exe "normal! g\'\\""')
        end
      end
    end
  }
)

-------------------------------------------------------------------------------
--
-- Nvim-Tree
--
-------------------------------------------------------------------------------

-- Automatically close the tab/vim when nvim-tree is the last window in the tab.
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*NvimTree_*",
    callback = function(args)
      -- Count leftover windows
      n_wins = 0
      for _ in pairs(vim.api.nvim_list_wins()) do n_wins = n_wins + 1 end

      if n_wins == 1 then
        vim.api.nvim_command('silent! quit')
      end
    end,
    desc = "Quit if Nvim-Tree is last window",
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*NvimTree_*",
    callback = function(args)
        vim.api.nvim_command('set cursorline')
    end,
    desc = "Set Cursorline for nvim tree",
})


-------------------------------------------------------------------------------
--
-- LSP related
--
-------------------------------------------------------------------------------

-- Format file and organize imports on save
local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.tf", "*.tfvars", "*.rs"},
  callback = function()
    -- vim.lsp.buf.format({ timeout_ms = 200 })
    vim.lsp.buf.format({async=false})
  end,
  group = format_sync_grp,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return nil
    end

    for _, client in pairs(clients) do
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end

      -- set keymap to show inlay hints
      if client.server_capabilities.inlayHintProvider then
        vim.keymap.set('n', '<space>h', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), bufnr)
        end, { noremap = true, silent = true, buffer = bufnr, desc = '[lsp] toggle inlay hints'})
      end
    end

    require("plugins.lsp.keymappings").lsp_mappings()
  end
})


-- Print which client was started
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    print("Language Server Protocol started:", client.name, "!")
  end
})

-------------------------------------------------------------------------------
-- Go
-------------------------------------------------------------------------------

-- function organize_goimports(wait_ms)
--     local params = vim.lsp.util.make_range_params()
--     params.context = {only = {"source.organizeImports"}}
--     -- buf_request_sync defaults to a 1000ms timeout. Depending on your
--     -- machine and codebase, you may want longer. Add an additional
--     -- argument after params if you find that you have to write the file
--     -- twice for changes to be saved.
--     -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
--     for cid, res in pairs(result or {}) do
--       for _, r in pairs(res.result or {}) do
--         if r.edit then
--           local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
--           vim.lsp.util.apply_workspace_edit(r.edit, enc)
--         end
--       end
--     end
-- end
--
-- -- Format file and organize Go imports on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*.go",
--     callback = function(args)
--         organize_goimports(1000)
--         vim.lsp.buf.format({async = false})
--     end,
--     desc = "Format Go files",
-- })

-- Format file and organize Go imports on save
-- Run gofmt + goimports on save
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
  desc = "Format Go files",
})

-------------------------------------------------------------------------------
-- Terraform
-------------------------------------------------------------------------------

-- Use One-Dark for terraform files.
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = {"*.tf", "*.tfvars", "*.hcl"},
    callback = function(args)
      require('onedark').setup{
        style = 'darker'
      }
      require('onedark').load()
    end,
    desc = "Use One-Dark theme",
})
vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*.tf",
    callback = function(args)
        require('utils').SetupDefaultColorScheme()
    end,
    desc = "Use default colorscheme theme",
})

-- File detection override

-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--     pattern = {"*.tf", "*.tfvars", "*.hcl"},
--     callback = function(args)
--       vim.api.nvim_command('set filetype=hcl')
--       -- vim.api.nvim_exec([[
--       --   set filetype=hcl
--       -- ]], false)
--     end,
--     desc = "set filetype to hcl for terraform highlights",
-- })

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.tfstate", "*.tfstate.backup"},
    callback = function(args)
      vim.api.nvim_command('set filetype=json')
    end,
    desc = "set filetype to json for terraform state and backup files",
})


