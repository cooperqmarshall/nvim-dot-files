-- KEYMAPS
local keymap = vim.keymap
local opt = vim.opt

-- escape
-- keymap.set({"i", "c", "v"}, "jk", "<Esc>", { noremap = true })

-- center jumps
keymap.set("n", "n", "nzz", { noremap = true })
keymap.set("n", "N", "Nzz", { noremap = true })

keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

-- Save and Quit on enter
local cr_save_map_fn = function()
  if opt.modifiable:get() then
    keymap.set("n", "<CR>", ":w<CR>", { noremap = true, buffer = true })
  end
end
vim.api.nvim_create_augroup("set_cr_save_map", { clear = true })
vim.api.nvim_create_autocmd("BufRead",
  { group = "set_cr_save_map", pattern = "*", callback = cr_save_map_fn })
keymap.set("n", "<leader>q", ":wq<CR>", { noremap = true })
keymap.set("n", "<leader>Q", ":q<CR>", { noremap = true })

-- Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
-- which is the default
keymap.set("", "Y", "y$")

-- H and L to begining and end of line
keymap.set({ "n", "o", "v" }, "H", "^")
keymap.set({ "n", "o", "v" }, "L", "$")

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

function _G.toggle_diagnostics()
  if vim.g.diagnostics_visible then
    vim.diagnostic.config({ virtual_text = false })
    vim.g.diagnostics_visible = false
  else
    vim.diagnostic.config({ virtual_text = true })
    vim.g.diagnostics_visible = true
  end
end

keymap.set('n', '<leader>D', toggle_diagnostics)
keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, bufopts)
vim.api.nvim_create_augroup("format_buffer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre",
  { group = "format_buffer", pattern = "*", callback = vim.lsp.buf.format })

-- yank to system clipboard
keymap.set('v', '<leader>y', '"+y')
-- paste to system clipboard
keymap.set('n', '<leader>p', '"+p')
