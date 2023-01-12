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

-- augroup and autocmd
local group = vim.api.nvim_create_augroup("statagroup", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "stata" },
	callback = function()
		vim.keymap.set("n", "<localleader>ra", close_float, { silent = true })
	end,
	group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "stata" },
	callback = function()
		vim.keymap.set("n", "<localleader>rv", ":MagmaInit stata<CR>", { silent = true })
	end,
	group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "stata" },
	callback = function()
		vim.keymap.set("n", "<localleader>d", ":MagmaEvaluateLine<CR>", { silent = true })
	end,
	group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "stata" },
	callback = function()
		vim.keymap.set("x", "<localleader>sd", ":<C-u>MagmaEvaluateVisual<CR>`>z<CR>", { silent = true })
	end,
	group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "stata" },
	callback = function()
		vim.keymap.set("n", "<localleader>rd", ":MagmaDelete<CR>", { silent = true })
	end,
	group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "stata" },
	callback = function()
		vim.keymap.set("n", "<localleader>ro", ":MagmaShowOutput<CR>", { silent = true })
	end,
	group = group,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "stata" },
	callback = function()
		vim.keymap.set("n", "<localleader>a", ":noautocmd MagmaEnterOutput<CR>", { silent = true })
	end,
	group = group,
})
