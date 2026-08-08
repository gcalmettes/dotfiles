local M = {
  -- check if file exists
  exists = function(filename)
    local isPresent = true
    -- Opens a file
    f = io.open(filename)

    -- if file is not present, f will be nil
    if not f then
        isPresent = false
    else
        -- close the file  
        f:close()
    end

    -- return status
    return isPresent
  end,
}

return M
