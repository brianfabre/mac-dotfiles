local M = {

	{
		"akinsho/toggleterm.nvim",
		keys = { "<leader>lg" },
		version = "*",
		config = function()
			require("toggleterm").setup({
				close_on_exit = true,
				direction = "float",
				float_opts = {
					border = "double",
					width = function()
						return math.floor(vim.o.columns * 0.9)
					end,
					height = function()
						return math.floor(vim.o.lines * 0.9)
					end,
				},
				-- function to run on opening the terminal
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(
						term.bufnr,
						"n",
						"q",
						"<cmd>close<CR>",
						{ noremap = true, silent = true }
					)
				end,
				-- function to run on closing the terminal
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
			-- local lf = Terminal:new({ cmd = "lf", hidden = true })

			function _lazygit_toggle()
				lazygit:toggle()
			end

			-- vim.api.nvim_set_keymap(
			vim.keymap.set("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

			--//------------------------------------------//--
			--//     works but messes with settings,      //--
			--//   e.g. removes numbers, adds tabline,    //--
			--//                   etc.                   //--
			--//------------------------------------------//--
			-- -- lf file picker
			-- local temp_path = "/tmp/lfpickerpath"
			-- local lfpicker = Terminal:new({
			-- 	cmd = "lf -selection-path " .. temp_path,
			-- 	hide_numbers = "false",
			-- 	on_close = function(term)
			-- 		local file = io.open(temp_path, "r")
			-- 		if file ~= nil then
			-- 			vim.cmd("tabe " .. file:read("*a"))
			-- 			file:close()
			-- 			os.remove(temp_path)
			-- 		end
			-- 	end,
			-- })

			-- function _lfpicker_toggle()
			-- 	lfpicker:toggle()
			-- end

			-- vim.api.nvim_set_keymap("n", "<leader>lf", "<cmd>lua _lfpicker_toggle()<CR>", { noremap = true, silent = true })
		end,
	},
}

return M
