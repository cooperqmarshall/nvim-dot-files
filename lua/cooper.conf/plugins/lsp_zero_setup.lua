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

local ok, mason = pcall(require, 'mason')
if (ok) then mason.setup() end
