local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('frankier/neovim-colors-solarized-truecolor-only')
Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')

Plug('rodjek/vim-puppet')

Plug('tpope/vim-fugitive')
Plug('tpope/vim-rhubarb')
Plug('shumphrey/fugitive-gitlab.vim')
Plug('airblade/vim-gitgutter')

Plug('neovim/nvim-lspconfig')

Plug('nvim-lua/plenary.nvim')

Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/cmp-path')
Plug('petertriho/cmp-git')
Plug('hrsh7th/nvim-cmp')
vim.call('plug#end')

--[[
to look at:
- https://github.com/rmagatti/goto-preview
]]--

vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1

vim.cmd('silent! colorscheme solarized')

vim.g.airline_theme='base16_solarized_dark'

vim.opt.signcolumn='yes'

  -- Set up nvim-cmp.
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<TAB>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require('cmp_git').setup()

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsps = {'pylsp', 'rubocop'}
for i, lsp in ipairs(lsps) do
  vim.lsp.config(lsp, {
    capabilities = capabilities
  })
  vim.lsp.enable(lsp)
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local bufmap = function(mode, rhs, lhs)
      vim.keymap.set(mode, rhs, lhs, {buffer = event.buf})
    end

    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap({'n', 'x'}, 'gq', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
  end,
})

vim.diagnostic.config({
  virtual_text = true,
})

vim.g.fugitive_gitlab_domains = {'https://gitlab.cee.redhat.com', 'https://salsa.debian.org'}
