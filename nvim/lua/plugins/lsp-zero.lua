return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = true,
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        formatting = lsp_zero.cmp_format({details = true}),
        sources = {
          {name = 'nvim_lsp'},
          {name = 'luasnip'},
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
-- LSP
{
  'neovim/nvim-lspconfig',
  cmd = {'LspInfo', 'LspInstall', 'LspStart'},
  event = {'BufReadPre', 'BufNewFile'},
  dependencies = {
    {'hrsh7th/cmp-nvim-lsp'},
    {'williamboman/mason-lspconfig.nvim'},
  },
  config = function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.extend_lspconfig()

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({buffer = bufnr})
    end)

    -- let lsp-zero handle lsp installation
    lsp_zero.setup_servers({
      'ts_ls',        -- typescript
      'pyright',      -- python
      'terraformls',  -- terraform
      'jsonls',       -- json
      'lua_ls',       -- lua
      'gopls',        -- go
      'html',         -- html
      'cssls',        -- css 
      'tailwindcss',  -- tailwind      
    })

    local lspconfig = require('lspconfig')

    -- manual lsp setup
    lspconfig.ts_ls.setup({
      on_attach = function(client, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})
      end,
    })

    lspconfig.pyright.setup({})
    lspconfig.terraformls.setup({})
    lspconfig.jsonls.setup({})
    lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
    lspconfig.gopls.setup({})
  end
}
}
