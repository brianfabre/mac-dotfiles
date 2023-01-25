local function alert(body)
	require("notify")(body, "info", { title = "Test" })
end

-- local bufnr = vim.api.nvim_get_current_buf()
-- local pos = vim.api.nvim_win_get_cursor(0)
-- local servname = vim.api.nvim_get_vvar("servername")
-- local lc = vim.api.nvim_buf_line_count(bufnr)

local function countbuf()
	local buflist = vim.api.nvim_list_bufs()
	local count = 0
	for _, b in ipairs(buflist) do
		local islisted = vim.api.nvim_buf_get_option(b, "buflisted")
		if islisted then
			count = count + 1
		end
	end
	if count > 1 then
		vim.o.showtabline = 2
	else
		vim.o.showtabline = 0
	end
end

-- alert(vim.inspect(servname))
-- alert(vim.inspect(bufcount))
