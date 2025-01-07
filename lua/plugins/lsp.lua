return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter', -- Load only when needed
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v0.*', -- More specific version constraint
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
    },
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- LSP attach configuration
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to definition/references
          map('gd', vim.lsp.buf.definition, 'Goto Definition')
          map('gr', vim.lsp.buf.references, 'Goto References')
          map('gI', vim.lsp.buf.implementation, 'Goto Implementation')
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gK', vim.lsp.buf.signature_help, 'Signature Help')

          -- Workspace management
          map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
          map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
          map('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, 'List Workspace Folders')

          -- Code actions and modifications
          map('<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
          -- map('<leader>f', function()
          --   vim.lsp.buf.format({ async = true })
          -- end, 'Format Buffer')

          -- Diagnostic navigation
          map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
          map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
          map('<leader>e', vim.diagnostic.open_float, 'Show Diagnostic')
          map('<leader>q', vim.diagnostic.setloclist, 'Set Location List')

          -- Buffer-local options
          vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Enable inlay hints if available
          local inlay_hint = vim.lsp.inlay_hint
          if inlay_hint and vim.fn.has 'nvim-0.10' == 1 then
            pcall(inlay_hint.enable, event.buf, true)
          end
        end,
      })

      -- Server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
      }

      -- Setup capabilities once
      local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('blink.cmp').get_lsp_capabilities())

      -- Tool installation
      require('mason-tool-installer').setup {
        ensure_installed = vim.list_extend(vim.tbl_keys(servers), { 'stylua' }),
      }

      -- LSP setup
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup(vim.tbl_deep_extend('force', { capabilities = capabilities }, servers[server_name] or {}))
          end,
        },
      }
    end,
  },
}
