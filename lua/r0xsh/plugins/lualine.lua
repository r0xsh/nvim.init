return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local function get_codeium_status()
      local status = vim.api.nvim_call_function('codeium#GetStatusString', {})
      return '{…}' .. status
    end
    local marlin = require 'marlin'

    local marlin_component = function()
      local indexes = marlin.num_indexes()
      if indexes == 0 then
        return ''
      end
      local cur_index = marlin.cur_index()

      return ' ' .. cur_index .. '/' .. indexes
    end
    require('lualine').setup {
      options = {
        icons_enabled = false,
        -- theme = 'oxocarbon',
        -- theme = 'jellybeans',
        component_separators = '|',
        section_separators = '',
        refresh = {
          statusline = 250,
          tabline = 1000,
          winbar = 1000,
        },
        disabled_filetypes = { 'neo-tree' },
      },
      sections = {
        lualine_c = { 'filename', marlin_component },
        -- lualine_y = { get_codeium_status },
      },
    }
  end,
}
