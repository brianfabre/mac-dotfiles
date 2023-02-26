local M = {
	"nvim-telescope/telescope-project.nvim",
	config = function()
		require("telescope").load_extension("project")
		vim.api.nvim_set_keymap(
			"n",
			"<leader>fp",
			":lua require'telescope'.extensions.project.project{}<CR>",
			{ noremap = true, silent = true, desc = "Projects" }
		)
	end,
}

return M
