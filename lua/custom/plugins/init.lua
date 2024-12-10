-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    "desdic/marlin.nvim",
    opts = {},
    config = function(_, opts)
        local marlin = require("marlin")
        marlin.setup(opts)

        local keymap = vim.keymap.set
        keymap("n", "<Leader>fa", function() marlin.add() end, {  desc = "add file" })
        keymap("n", "<Leader>fd", function() marlin.remove() end, {  desc = "remove file" })
        keymap("n", "<Leader>fx", function() marlin.remove_all() end, {  desc = "remove all for current project" })
        keymap("n", "<Leader>fi", function() marlin.move_up() end, {  desc = "move up" })
        keymap("n", "<Leader>fo", function() marlin.move_down() end, {  desc = "move down" })
        -- keymap("n", "<Leader>fs", function() marlin.sort() end, {  desc = "sort" })
        -- keymap("n", "<Leader>fn", function() marlin.next() end, {  desc = "open next index" })
        -- keymap("n", "<Leader>fp", function() marlin.prev() end, {  desc = "open previous index" })
        -- keymap("n", "<Leader><Leader>", function() marlin.toggle() end, {  desc = "toggle cur/last open index" })

        for index = 1,4 do
            keymap("n", "<Leader>"..index, function() marlin.open(index) end, {  desc = "goto "..index })
        end
    end
},
  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
  --   'nyoom-engineering/oxocarbon.nvim',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- Load the colorscheme here
  --     -- vim.cmd.colorscheme 'oxocarbon'
  --
  --     -- You can configure highlights by doing something like
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local function get_codeium_status()
        local status = vim.api.nvim_call_function('codeium#GetStatusString', {})
        return '{…}' .. status
      end
      local marlin = require("marlin")

      local marlin_component = function()
        local indexes = marlin.num_indexes()
        if indexes == 0 then
          return ""
        end
        local cur_index = marlin.cur_index()

        return " " .. cur_index .. "/" .. indexes
      end
      require('lualine').setup {
        options = {
          icons_enabled = false,
          -- theme = 'oxocarbon',
          component_separators = '|',
          section_separators = '',
          refresh = {
            statusline = 250,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_c = { 'filename', marlin_component },
          -- lualine_y = { get_codeium_status },
        },
      }
    end,
  },
  {
    'Exafunction/codeium.vim',
    version = '1.8.37',
    event = 'BufEnter',
    config = function()
      vim.g.codeium_idle_delay = 650
      vim.keymap.set('i', '<c-;>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-,>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true })
    end,
  },
  -- { 'elkowar/yuck.vim', ft = 'yuck' },
  -- { 'rescript-lang/vim-rescript', ft="rescript" },
  -- {
  --   "jinzhongjia/LspUI.nvim",
  --   branch = "main",
  --   config = function()
  --     require("LspUI").setup({
  --       -- config options go here
  --     })
  --   end
  -- }
}
