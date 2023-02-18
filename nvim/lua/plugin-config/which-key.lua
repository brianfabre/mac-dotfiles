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
		name = "Search ...",
		p = { ":cd ~/.local/share/nvim/lazy<CR> :Telescope find_files <CR>", "Plugins" },
		c = { ':cd ~/.config<CR> :lua require"telescope.builtin".find_files({ hidden = true })<CR>', "Config" },
		r = { ":cd ~/Documents/R<CR> :Telescope find_files <CR>", "R" },
		s = { ":cd ~/Documents/Stata<CR> :Telescope find_files <CR>", "Stata" },
		l = { ":cd /Volumes/MacAsahi/Documents/Latex<CR> :Telescope find_files <CR>", "Latex" },
		d = { ":cd ~/Documents<CR> :Telescope find_files <CR>", "Documents" },
		-- p = { ":cd ~/Documents/PycharmProjects<CR> :Telescope find_files <CR>", "Pycharm search" },
	},
	w = {
		name = "Wiki",
	},
}, { prefix = "<leader>" })
