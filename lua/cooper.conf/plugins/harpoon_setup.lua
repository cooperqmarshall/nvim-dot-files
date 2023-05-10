if pcall(require, "harpoon.ui") and pcall(require, "harpoon.mark") then
  keymap.set("n", "<leader>m", function() require('harpoon.mark').add_file() end, { noremap = true, silent = true })
  keymap.set("n", "<leader>h", function() require('harpoon.ui').toggle_quick_menu() end,
    { noremap = true, silent = true })
  keymap.set({ "n", "i" }, "<C-h>", function() require('harpoon.ui').nav_file(1) end, { noremap = true, silent = true })
  keymap.set({ "n", "i" }, "<C-j>", function() require('harpoon.ui').nav_file(2) end, { noremap = true, silent = true })
  keymap.set({ "n", "i" }, "<C-k>", function() require('harpoon.ui').nav_file(3) end, { noremap = true, silent = true })
  --	keymap.set({ "n", "i" }, "<C-l>", function() require('harpoon.ui').nav_file(4) end, { noremap = true, silent = true })
end
