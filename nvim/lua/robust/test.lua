local function alert(body)
	require("notify")(body, "info", { title = "Test" })
end

local bufnr = vim.api.nvim_get_current_buf()
local pos = vim.api.nvim_win_get_cursor(0)

print("hello")

alert(vim.inspect(bufnr))
alert(vim.inspect(pos))
