local ok, oil = pcall(require, 'oil')
if (ok) then
  oil.setup({
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    }
  })
end
