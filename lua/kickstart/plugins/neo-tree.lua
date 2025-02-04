-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local function hide_eob(args)
  local bg_color = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
  vim.wo[vim.fn.bufwinid(args.buf)].winhl = 'EndOfBuffer:NeoTreeEndOfBuffer'
  vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { fg = bg_color })
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    {
      '\\',
      '<cmd>Neotree position=right reveal<cr>',
      desc = 'NeoTree reveal',
      silent = true,
    },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'neo-tree',
      callback = hide_eob,
    })
  end,
}
