local remap = vim.api.nvim_set_keymap

require("compe").setup{
  enabled = true,
  debug = false,
  autocomplete = true,
  documentation = true,
  min_length = 2,
  preselect = "disable",
  source_timeout = 200,
  incomplete_delay = 400,
  throttle_time = 200,
  allow_prefix_unmatch = true,

  source = {
    path = true,
    buffer = {
      enable = true,
      priority = 1, -- last priority
    },
    nvim_lua = true,
    nvim_lsp = {
      enable = true,
      priority = 10001, -- takes precedence over file completion
    },
  },
}
