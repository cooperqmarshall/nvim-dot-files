-- Cooper's Neovim init.lua

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

-- search
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

opt.scrolloff = 8

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- KEYMAPS
local keymap = vim.keymap

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

-- Toggle Term

vim.api.nvim_create_user_command("ToggleTermSendVisualSelection",
  function(opts)
    send_term("visual_selection", false, opts.args)
  end,
  { range = true, nargs = "?", force = true }
)

-- Background transparancy
vim.api.nvim_create_augroup("user_colors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme",
  { group = "user_colors", pattern = "*", command = "highlight Normal ctermbg=NONE guibg=NONE" })
vim.api.nvim_create_autocmd("ColorScheme",
  { group = "user_colors", pattern = "*", command = "highlight NormalNC ctermbg=NONE guibg=NONE" })
vim.api.nvim_create_autocmd("ColorScheme",
  { group = "user_colors", pattern = "*", command = "highlight NormalSB ctermbg=NONE guibg=NONE" })
vim.api.nvim_create_autocmd("ColorScheme",
  { group = "user_colors", pattern = "*", command = "highlight SignColumn ctermbg=NONE guibg=NONE" })


-- Plugins
if pcall(require, 'plugins') then

  -- LSP Zero
  local ok, lsp = pcall(require,'lsp-zero')
  if (ok) then 
    lsp.preset({
      name = 'minimal',
      set_lsp_keymaps = true,
      manage_nvim_cmp = true,
      suggest_lsp_servers = false,
    })
    lsp.setup()
  end

  local ok, mason = pcall(require,'mason')
  if (ok) then mason.setup() end

end

-- toggle_term
vim.api.nvim_create_user_command("ToggleTermSendVisualLines",
  function(opts)
    send_term("visual_lines", false, opts.args)
  end,
  { range = true, nargs = "?", force = true }
)
keymap.set("n", "<leader>t", ":ToggleTerm direction=vertical<CR>", { noremap = true, silent = true })
keymap.set("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })
keymap.set("v", "<S-CR>", ":ToggleTermSendVisualLines<CR>", { noremap = true, silent = true })
keymap.set("n", "<S-CR>", ":ToggleTermSendCurrentLine<CR>", { noremap = true, silent = true })

-- Plugins
if pcall(require, 'nvim-treesitter.configs') then
  require('nvim-treesitter.configs').setup {
    ensure_installed = "all",
    sync_install = false,

    highlight = {
      enable = false,
      additional_vim_regex_highlighting = false,
    },
  }
end


if pcall(require, "fzf-lua") then
  vim.api.nvim_set_keymap('n', '<c-P>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })
end

-- harpoon
if pcall(require, "harpoon.ui") and pcall(require, "harpoon.mark") then
  keymap.set("n", "<leader>m", function() require('harpoon.mark').add_file() end, { noremap = true, silent = true })
  keymap.set("n", "<leader>h", function() require('harpoon.ui').toggle_quick_menu() end,
    { noremap = true, silent = true })
  keymap.set({ "n", "i" }, "<C-h>", function() require('harpoon.ui').nav_file(1) end, { noremap = true, silent = true })
  keymap.set({ "n", "i" }, "<C-j>", function() require('harpoon.ui').nav_file(2) end, { noremap = true, silent = true })
  keymap.set({ "n", "i" }, "<C-k>", function() require('harpoon.ui').nav_file(3) end, { noremap = true, silent = true })
  --	keymap.set({ "n", "i" }, "<C-l>", function() require('harpoon.ui').nav_file(4) end, { noremap = true, silent = true })
end

-- keymap.set({ "n", "i" }, "<C-m>", function() vim.cmd("nohlsearch") end, { noremap = true, silent = true })

-- gitsigns
if pcall(require, "gitsigns") then
  require('gitsigns').setup()
end

-- colorscheme
if pcall(require, "dracula") then
  require("dracula").setup()
end

if pcall(require, "tokyonight") then
  require("tokyonight").setup {
    style = "night"
  }
end

require("catppuccin").setup({
	flavor = "mocha",
	transparent_background = true
})

vim.cmd.colorscheme 'catppuccin'

-- feline
if pcall(require, "feline") then
local ctp_feline = require('catppuccin.groups.integrations.feline')

ctp_feline.setup({})
  require('feline').setup({
    components = ctp_feline.get(),
  })
end


vim.g.diagnostics_visible = true

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

-- fugitive
keymap.set("n", "<leader>g", ":vertical G<CR>")

