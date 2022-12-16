local rt = require("rust-tools")
local M = {}

-- Format file and organize Go imports on save
local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})

-- https://github.com/simrat39/rust-tools.nvim
local opts = {
    tools = { -- rust-tools options
        -- -- Automatically set inlay hints (type hints)
        -- autoSetHints = true,

        -- -- how to execute terminal commands
        -- -- options right now: termopen / quickfix
        -- executor = require("rust-tools/executors").termopen,

        runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true
            -- rest of the opts are forwarded to telescope
        },

        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true
            -- rest of the opts are forwarded to telescope
        },

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {
            auto = true,

            -- -- Only show inlay hints for the current line
            -- only_current_line = false,

            -- -- Event which triggers a refersh of the inlay hints.
            -- -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- -- not that this may cause  higher CPU usage.
            -- -- This option is only respected when only_current_line and
            -- -- autoSetHints both are true.
            -- only_current_line_autocmd = "CursorHold",

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,

            -- prefix for parameter hints
            parameter_hints_prefix = "",
            -- parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "",
            -- other_hints_prefix = "=> ",

            -- -- whether to align to the length of the longest line in the file
            -- max_len_align = false,

            -- -- padding from the left if max_len_align is true
            -- max_len_align_padding = 1,

            -- -- whether to align to the extreme right or not
            -- right_align = false,

            -- -- padding from the right if right_align is true
            -- right_align_padding = 7,

            -- -- The color of the hints
            -- highlight = "Comment",
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                {"╰", "FloatBorder"}, {"│", "FloatBorder"}
            },

            -- whether the hover action window gets automatically focused
            auto_focus = false
        },

        -- -- settings for showing the crate graph based on graphviz and the dot
        -- -- command
        -- crate_graph = {
        --     -- Backend used for displaying the graph
        --     -- see: https://graphviz.org/docs/outputs/
        --     -- default: x11
        --     backend = "x11",
        --     -- where to store the output, nil for no output stored (relative
        --     -- path from pwd)
        --     -- default: nil
        --     output = nil,
        --     -- true for all crates.io and external crates, false only the local
        --     -- crates
        --     -- default: true
        --     full = true,
        -- }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
      on_attach = function(_, bufnr)
        -- -- Hover actions
        -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- -- Code action groups
        -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
      settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
          -- enable clippy on save
          checkOnSave = {
            command = "clippy",
          },
        }
      },
    }, -- rust-analyer options

    -- debugging stuff
    -- dap = {
    --     adapter = {
    --         type = 'executable',
    --         command = 'lldb-vscode',
    --         name = "rt_lldb"
    --     }
    -- }
}

M.config = {
  override_client_setup = function(server_opts)
    opts.server = server_opts or {}
    require('rust-tools').setup(opts)
  end,
}

return M
