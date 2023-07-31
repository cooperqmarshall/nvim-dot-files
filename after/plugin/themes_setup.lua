if pcall(require, "dracula") then
  require("dracula").setup {
    transparent_bg = true
  }
end

if pcall(require, "tokyonight") then
  require("tokyonight").setup {
    style = "night",
    transparent = true,
  }
end

if pcall(require, "catppuccin") then
  require("catppuccin").setup {
    flavor = "mocha",
    transparent_background = true
  }
end

if pcall(require, "nordic") then
  require 'nordic' .setup {
    -- Enable bold keywords.
    bold_keywords = false,
    -- Enable general editor background transparency.
    transparent_bg = true
  }
end

vim.cmd.colorscheme "dracula"
