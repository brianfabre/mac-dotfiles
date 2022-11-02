-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
require("nvim-tree").setup({
    sync_root_with_cwd = true,
    reload_on_bufenter = true,
    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
      },
})
