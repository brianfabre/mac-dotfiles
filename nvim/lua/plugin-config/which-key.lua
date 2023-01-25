vim.o.timeout = true
vim.o.timeoutlen = 500
require("which-key").setup({
	plugins = {
		spelling = {
			enabled = true,
		},
	},
	window = {
		border = "single",
	},
	-- ignore_missing = true,
})

local wk = require("which-key")
wk.register({
	c = {
		name = "Directory",
	},
	f = {
		name = "Telescope",
	},
	l = {
		name = "Open ...",
		g = { "Lazygit" },
	},
	p = {
		name = "Run code",
	},
	q = {
		name = "Quit ...",
	},
	s = {
		name = "Start menu",
	},
	w = {
		name = "Wiki",
	},
}, { prefix = "<leader>" })
