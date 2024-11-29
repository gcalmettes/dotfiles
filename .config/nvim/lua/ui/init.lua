local module_name = ... or "init.d"
-- :p modifier gives absolute path. % is only relative path.
local nvim_root_init = vim.fn.expand('%:p')
local nvim_root_directory = vim.fn.fnamemodify(current_file_path, ':p:h')
local current_base = '/lua/' .. module_name
local current_directory = nvim_root_directory .. current_base

local handle = vim.loop.fs_scandir(current_directory)

exclude = exclude or {}
-- Being called from an `init` file, so always exclude it by default
exclude["init"] = true

while handle do
    name, typ = vim.loop.fs_scandir_next(handle)
    if not name then
      -- Done, nothing left
      break
    end
    ext = vim.fn.fnamemodify(name, ":e")
    req = vim.fn.fnamemodify(name, ":r")

    if ((ext == "lua" and typ == "file") or (typ == "directory")) and not exclude[req] then
      local file_path = module_name ..".".. req
      success, res = pcall(require, module_name .. "." .. req)

      if not success then
        print("Error loading module " .. req .. ":" .. res)
      end
    end
end
