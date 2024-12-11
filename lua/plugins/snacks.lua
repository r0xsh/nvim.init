return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      terminal = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      -- statuscolumn = { enabled = true },
      -- words = { enabled = true },
    },
    keys = {
      {
        '²',
        function()
          Snacks.terminal()
        end,
        mode = { 'n', 'v', 'i', 't' },
        desc = 'Toggle Terminal',
      },
    },
  },
}
