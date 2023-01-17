require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = { "python", "markdown", "lua", "vim", "latex", "r" },
	auto_install = true,
	highlight = {
		enable = true,
		disable = { "markdown" },
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			scope_incremental = "<S-CR>",
			node_decremental = "<BS>",
		},
	},
})
