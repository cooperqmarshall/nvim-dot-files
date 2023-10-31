local ok, feline = pcall(require, "feline")
if (ok) then
  local ctp_feline = require('catppuccin.groups.integrations.feline')
  ctp_feline.setup {}

  feline.setup {
    components = ctp_feline.get(),
  }
end
