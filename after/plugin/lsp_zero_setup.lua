local ok, lsp = pcall(require, 'lsp-zero')
if (ok) then
  lsp.preset({
    name = 'minimal',
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = false,
  })
  lsp.setup()
end

local ok, cmp = pcall(require, 'cmp')
if (ok) then
  cmp.setup({
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }
  })
end

local ok, mason = pcall(require, 'mason')
if (ok) then mason.setup() end

local ok, mason_lsp = pcall(require, 'mason-lspconfig')
if (ok) then mason_lsp.setup() end

require("mason-null-ls").setup({
  ensure_installed = {
    -- Opt to list sources here, when available in mason.
  },
  automatic_installation = false,
  handlers = {},
})
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- Anything not supported by mason.
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.completion.spell,
    -- null_ls.builtins.diagnostics.sqlfluff
  },
})
-- Make sure you setup `cmp` after lsp-zero

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  }
})

require("luasnip.loaders.from_vscode").lazy_load()
