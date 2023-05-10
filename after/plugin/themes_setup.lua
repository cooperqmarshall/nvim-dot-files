if pcall(require, "dracula") then
  require("dracula").setup()
end

if pcall(require, "tokyonight") then
  require("tokyonight").setup {
    style = "night"
  }
end

if pcall(require, "catppuccin") then
  require("catppuccin").setup({
    flavor = "mocha",
    transparent_background = true
  })
end

vim.cmd.colorscheme "catppuccin"
