local ok, fzf = pcall(require, "fzf-lua")
if (ok) then
  vim.keymap.set('n', '<c-P>', function() fzf.files() end, { noremap = true, silent = true })
end
