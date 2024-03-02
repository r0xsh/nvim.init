-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Load the colorscheme here
      vim.cmd.colorscheme 'oxocarbon'

      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'arkav/lualine-lsp-progress' },
    config = function()
      local function get_codeium_status()
        local status = vim.api.nvim_call_function('codeium#GetStatusString', {})
        return '{…}' .. status
      end
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'oxocarbon',
          component_separators = '|',
          section_separators = '',
          refresh = {
            statusline = 250,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_c = { 'filename', 'lsp_progress' },
          lualine_y = { get_codeium_status },
        },
      }
    end,
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      vim.g.codeium_idle_delay = 850
      vim.keymap.set('i', '<c-;>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-,>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true })
    end,
  },
}
