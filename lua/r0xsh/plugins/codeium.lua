return {
  'Exafunction/codeium.vim',
  -- version = '1.8.37',
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
}
