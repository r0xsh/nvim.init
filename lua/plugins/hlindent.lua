return {
  {
    'nvimdev/indentmini.nvim',
    config = function()
      require('indentmini').setup { only_current = true }
      -- vim.cmd.highlight('IndentLine guifg=#333333')
      vim.cmd.highlight 'IndentLineCurrent guifg=#333333'
    end,
  },
}
