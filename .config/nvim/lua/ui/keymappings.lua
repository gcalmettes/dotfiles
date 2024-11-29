local map = require("utils").Keymap

map('', '<leader>di', function()
  require('ui.docker').docker_images()
end)

map('', '<leader>dv', function()
  require('ui.docker').docker_volumes()
end)
map('', '<leader>dp', function()
  require('ui.docker').docker_ps()
end)
