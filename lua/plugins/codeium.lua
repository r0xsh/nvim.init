return {
  {
    'Exafunction/codeium.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('codeium').setup {
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          idle_delay = 750,
        },
        workspace_root = {
          use_lsp = true,
        },
      }
    end,
  },
}
