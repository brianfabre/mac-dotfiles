local M = {
    "nvim-telescope/telescope-project.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("telescope").load_extension("project")
        vim.api.nvim_set_keymap(
            "n",
            "<leader>sp",
            ":lua require'telescope'.extensions.project.project{}<CR>",
            { noremap = true, silent = true, desc = "Projects" }
        )
    end,
}

return M
