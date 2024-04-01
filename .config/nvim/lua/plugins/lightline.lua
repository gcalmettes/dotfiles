return {
  'itchyny/lightline.vim',
  lazy = false, -- also load at start since it's UI
  config = function()
    -- no need to also show mode in cmd line when we have bar
    vim.o.showmode = false
    vim.g.lightline = {
      active = {
        left = {
          { 'mode', 'paste' },
          { 'readonly', 'filename', 'modified' }
        },
        right = {
          { 'lineinfo' },
          { 'percent' },
          { 'fileencoding', 'filetype' }
        },
      },
      component_function = {
        filename = 'LightlineFilename'
      },
    }
    function LightlineFilenameInLua(opts)
      if vim.fn.expand('%:t') == '' then
        filename =  '[No Name]'
      else
        -- replace HOME by tilde in filename
        filename = vim.fn.getreg('%'):gsub(os.getenv('HOME'), "~")
      end
      if vim.api.nvim_win_get_width(0) < 107 then
        -- ":." Reduce file name to be relative to current directory, if possible.
        -- File name is unmodified if it is not below the current directory.
        -- The :~ is optional. It will reduce the path relative to your home folder if possible
        return vim.fn.pathshorten(vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.'))
      else
        return filename
      end
    end
    -- https://github.com/itchyny/lightline.vim/issues/657
    vim.api.nvim_exec(
      [[
      function! g:LightlineFilename()
        return v:lua.LightlineFilenameInLua()
      endfunction
      ]],
      true
    )
  end
}
