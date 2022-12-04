require('plugins')
require('lsp_stuff')

-- OPTIONS
local opt = vim.opt
local g = vim.g

g.mapleader = " "
-- netrw configs
g.netrw_keepdir = 1
-- g.netrw_winsize = 25
g.netrw_banner = 0
-- show jump distance instead of line numeber
opt.relativenumber = true
-- show current line number
opt.nu = true

opt.updatetime = 50
-- opt.cmdheight = 1
opt.swapfile = false
-- persist undos
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- idk
opt.termguicolors = true

opt.smartcase = true
opt.ignorecase = true

opt.confirm = true

opt.splitbelow = true
opt.splitright = true

-- tabs
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- KEYMAPS
local keymap = vim.keymap

keymap.set("n", "n", "nzz", { noremap = true })
keymap.set("n", "N", "Nzz", { noremap = true })

keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })
-- Better Save and Quit

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
keymap.set("n", "H", "^")
keymap.set("n", "L", "$")

-- netrw keymaps

local set_correct_netrw_toggle = function()
  -- vim.cmd('lua print(vim.bo.filetype)')
  if vim.bo.filetype == "netrw" then
    keymap.set("n", "<leader>e", ":Rexplore<CR>", { silent = true })
  else
    keymap.set("n", "<leader>e", ":Explore<CR>", { silent = true })
  end
end

vim.api.nvim_create_augroup("netrw_toggle", { clear = true })
vim.api.nvim_create_autocmd("FileType",
  { group = "netrw_toggle", pattern = "*", callback = set_correct_netrw_toggle })

keymap.set("n", "<leader>E", ":Explore %:p:h<CR>", { noremap = true, silent = true })

-- Plugins
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

vim.api.nvim_create_augroup("user_colors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme",
  { group = "user_colors", pattern = "*", command = "highlight Normal ctermbg=NONE guibg=NONE" })
vim.api.nvim_create_autocmd("ColorScheme",
  { group = "user_colors", pattern = "*", command = "highlight NormalNC ctermbg=NONE guibg=NONE" })
vim.api.nvim_create_autocmd("ColorScheme",
  { group = "user_colors", pattern = "*", command = "highlight NormalSB ctermbg=NONE guibg=NONE" })
vim.api.nvim_create_autocmd("ColorScheme",
  { group = "user_colors", pattern = "*", command = "highlight SignColumn ctermbg=NONE guibg=NONE" })

vim.api.nvim_set_keymap('n', '<c-P>',
  "<cmd>lua require('fzf-lua').files()<CR>",
  { noremap = true, silent = true })

-- harpoon
keymap.set("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", { noremap = true, silent = true })

-- gitsigns
require('gitsigns').setup()

-- colorscheme
require("dracula").setup()
-- vim.cmd[[colorscheme dracula]]
require("tokyonight").setup {
  style = "night"
}
local theme = 'tokyonight'

vim.cmd('colorscheme ' .. theme)
