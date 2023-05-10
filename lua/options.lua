-- Options
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

vim.g.diagnostics_visible = true

