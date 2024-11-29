return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    config = function()
      -- nvim-dap uses five signs:
      -- - `DapBreakpoint` for breakpoints (default: `B`)
      -- - `DapBreakpointCondition` for conditional breakpoints (default: `C`)
      -- - `DapLogPoint` for log points (default: `L`)
      -- - `DapStopped` to indicate where the debugee is stopped (default: `→`)
      -- - `DapBreakpointRejected` to indicate breakpoints rejected by the debug
      --   adapter (default: `R`)
      --
      --
      -- You can customize the signs by setting them with the |sign_define()| function.
      -- vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl = "Yellow", linehl = "", numhl = "Yellow"})
      -- vim.fn.sign_define('DapStopped', {text='💡', texthl = "Green", linehl = "ColorColumn", numhl = "Green"})
      -- vim.fn.sign_define('DapBreakpointRejected', {text='🚷', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpoint', {text="⬢", texthl = "Yellow", linehl = "", numhl = "Yellow"})
      vim.fn.sign_define('DapStopped', {text="▶", texthl = "Green", linehl = "ColorColumn", numhl = "Green"})
      vim.fn.sign_define('DapBreakpointRejected', {text='⚠', texthl='Red', linehl='', numhl='Red'})
    end
  },
  -- A default "GUI" front-end for nvim-dap
  {
      "rcarriga/nvim-dap-ui",
      config = function()
          require("dapui").setup()
      end,
      dependencies = {
          "mfussenegger/nvim-dap",
          'nvim-neotest/nvim-nio',
      },
  },
  {
    "leoluz/nvim-dap-go",
    opts = {
      -- Additional dap configurations can be added.
      -- dap_configurations accepts a list of tables where each entry
      -- represents a dap configuration. For more details do:
      -- :help dap-configuration
      dap_configurations = {
        -- {
        --   -- Must be "go" or it will be ignored by the plugin
        --   type = "go",
        --   name = "Attach remote",
        --   mode = "remote",
        --   request = "attach",
        -- },
      },
      -- delve configurations
      delve = {
        -- the path to the executable dlv which will be used for debugging.
        -- by default, this is the "dlv" executable on your PATH.
        path = "dlv",
        -- time to wait for delve to initialize the debug session.
        -- default to 20 seconds
        initialize_timeout_sec = 20,
        -- a string that defines the port to start delve debugger.
        -- default to string "${port}" which instructs nvim-dap
        -- to start the process in a random available port.
        -- if you set a port in your debug configuration, its value will be
        -- assigned dynamically.
        port = "${port}",
        -- additional args to pass to dlv
        args = {},
        -- the build flags that are passed to delve.
        -- defaults to empty string, but can be used to provide flags
        -- such as "-tags=unit" to make sure the test suite is
        -- compiled during debugging, for example.
        -- passing build flags using args is ineffective, as those are
        -- ignored by delve in dap mode.
        -- avaliable ui interactive function to prompt for arguments get_arguments
        build_flags = {},
        -- the current working directory to run dlv from, if other than
        -- the current working directory.
        cwd = nil,
      },
      -- options related to running closest test
      tests = {
        -- enables verbosity when running the test.
        verbose = false,
      },
    },
    config = function(_, opts)
      -- require("dap-go").setup(opts)
      local dap_go = require('dap-go')
      local dap = require('dap')

      dap_go.setup()
      table.insert(dap.configurations.go, {
        type = 'delve',
        name = 'Kube connect',
        mode = 'remote',
        request = 'attach',
        substitutePath = {
          { from = '${workspaceFolder}', to = '/' },
        },
      })

      -- hack, see https://github.com/leoluz/nvim-dap-go/issues/43#issuecomment-1746423867
      dap.adapters.delve = {
        type = 'server',
        host = '127.0.0.1',
        port = "2345"
      }

    end
  }
}

-- local dap = {
--   adapters = {
--     go = {
--       type = "server",
--       port = 9004,
--     }
--   },
--   configurations = {
--     go = {
--       {
--          type = "go",
--          name = "delve container debug",
--          request = "attach",
--          mode = "remote",
--          substitutepath = {{
--            from = "${workspaceFolder}",
--            to = "/opt/app",
--          }},   
--       }
--     },
--   }
-- }
