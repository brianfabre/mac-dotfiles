-- function
local function close_float()
	-- removes any stuck floating window
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			vim.api.nvim_win_close(win, false)
			print("Closing window", win)
		end
	end
end

-- magma options
vim.g.magma_automatically_open_output = false
-- vim.g.magma_output_window_borders = false
vim.g.magma_image_provider = "kitty"

-- highlights for float
-- moved to base16 config
-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "", bg = "" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#112641" })

local group = vim.api.nvim_create_augroup("statagroup", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "stata" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<localleader>ra", close_float, { silent = true })
-- 	end,
-- 	group = group,
-- })
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "stata" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<localleader>rv", ":MagmaInit stata<CR>", { silent = true })
-- 	end,
-- 	group = group,
-- })
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "stata" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<localleader>d", ":MagmaEvaluateLine<CR>", { silent = true })
-- 	end,
-- 	group = group,
-- })
--
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "stata" },
	callback = function()
		vim.keymap.set("x", "<localleader>sd", ":<C-u>MagmaEvaluateVisual<CR>`>z<CR>", { silent = true })
	end,
	group = group,
})
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "stata" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<localleader>rd", ":MagmaDelete<CR>", { silent = true })
-- 	end,
-- 	group = group,
-- })
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "stata" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<localleader>ro", ":MagmaShowOutput<CR>", { silent = true })
-- 	end,
-- 	group = group,
-- })
--
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "stata" },
-- 	callback = function()
-- 		vim.keymap.set("n", "<localleader>a", ":noautocmd MagmaEnterOutput<CR>", { silent = true })
-- 	end,
-- 	group = group,
-- })
--
-- require("which-key").register({
-- 	["u"] = {
-- 		s = "share file",
-- 	},
-- }, {
-- 	buffer = vim.api.nvim_get_current_buf(), --- pass buffer number in option then it will work
-- 	prefix = "<localleader>",
-- })

vim.cmd([[
autocmd FileType stata lua whichkeyStata()
]])

_G.whichkeyStata = function()
	local wk = require("which-key")
	local buf = vim.api.nvim_get_current_buf()
	wk.register({
		["<localleader>"] = { name = "Magma" },
		["<localleader>i"] = { ":MagmaInit stata<CR>", "Initialize Magma" },
		["<localleader>d"] = { ":MagmaEvaluateLine<CR>", "Evaluate line" },
		-- visual mode doesnt work
		-- ["<localleader>v"] = { ":<C-u>MagmaEvaluateVisual<CR>`>z<CR>", "Evaluate visual" },
		["<localleader>r"] = { ":MagmaDelete<CR>", "Remove" },
		["<localleader>s"] = { ":MagmaShowOutput<CR>", "Show output" },
		["<localleader>e"] = { ":noautocmd MagmaEnterOutput<CR>", "Enter output" },
		["<localleader>c"] = { close_float, "Close float" },
	})
end
