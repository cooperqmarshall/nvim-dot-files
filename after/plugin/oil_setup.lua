local ok, oil = pcall(require, 'oil')
if (ok) then
  oil.setup({
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<leader>o"] = "actions.preview",
      ["<leader>e"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["g."] = "actions.toggle_hidden",
    },
    use_default_keymaps = false,
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    }
  })
end

-- open oil in file's directory
vim.keymap.set("n", "<leader>e", function() oil.open(vim.fn.expand('%:p:h')) end, { noremap = true, silent = true })
-- open oil in cwd
vim.keymap.set("n", "<leader>E", function() oil.open(vim.fn.getcwd()) end, { noremap = true, silent = true })
-- set cwd to the open directory in oil 
vim.keymap.set("n", "<leader>cd",
  function()
    vim.api.nvim_set_current_dir(oil.get_current_dir()); print("changed cwd to: " .. oil.get_current_dir())
  end, { noremap = true })
