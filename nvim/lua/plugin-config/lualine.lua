require("lualine").setup({
	options = {
		-- theme = "dracula-nvim",
		-- theme = "catppuccin",
		theme = "auto",
	},
	-- options = {
	-- 	icons_enabled = true,
	-- 	theme = 'auto',
	-- 	component_separators = { left = '', right = '' },
	-- 	section_separators = { left = '', right = '' },
	-- 	disabled_filetypes = {
	-- 		statusline = {},
	-- 		winbar = {},
	-- 	},
	-- 	ignore_focus = {},
	-- 	always_divide_middle = true,
	-- 	globalstatus = false,
	-- 	refresh = {
	-- 		statusline = 1000,
	-- 		tabline = 1000,
	-- 		winbar = 1000,
	-- 	},
	-- },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				path = 3,
			},
		},
		-- lualine_x = { "filetype" },
		lualine_x = {
			{
				require("lazy.status").updates,
				cond = require("lazy.status").has_updates,
				color = { fg = "#ff9e64" },
			},
			{ "filetype" },
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
