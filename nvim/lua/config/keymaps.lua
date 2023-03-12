local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- move between panes to left/bottom/top/right
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- move between buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
map("n", "<Leader>qq", ":bdelete!<CR>", { desc = "Quit buffer" })
map("n", "<Leader>qa", ":%bd|e#<CR>:bnext<CR>:bd<CR>e", { desc = "Quit all other buffers" })

-- move line/down
map("n", "<S-Up>", ":m-2<CR>")
map("n", "<S-Down>", ":m+<CR>")
map("v", "<S-Up>", ":m '<-2<CR>gv=gv")
map("v", "<S-Down>", ":m '>+1<CR>gv=gv")

-- copy to clipboard
map("v", "<Leader>y", '"*y')

-- no register for x
map("n", "x", '"_x')

-- leave insert mode
map("i", "jk", "<esc>")

-- save
map("n", "<leader>k", ":update<CR>", { desc = "Save" })

-- quit all
map("n", "<leader>qp", ":qa!<CR>", { desc = "Quit Neovim" })

-- file path
map("n", "<leader>cw", ":lua print(vim.fn.getcwd())<CR>", { desc = "Echo CWD" })
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { desc = "Set as working dir" })
map("n", "<leader>cp", ':let @+=expand("%:p")<CR>', { desc = "Path to clipboard" })

-- always centers after c-d/c-u
-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")

-- faster in/outdenting
map("i", "<<", "<c-d>")
map("i", ">>", "<c-t>")

-- allow the . to execute once for each line of a visual selection
map("v", ".", ":normal .<CR>")

-- open lazy.nvim
map("n", "<leader>ly", ":Lazy<CR>", { desc = "lazy.nvim" })

-- open nvim config
map("n", "<leader>li", ":e $MYVIMRC<CR>", { desc = "init.lua" })

-- resize windows
map("n", "<leader>=", ':exe "resize +2"<CR>', { desc = "Win size increase" })
map("n", "<leader>-", ':exe "resize -2"<CR>', { desc = "Win size decrease" })

-- / is used by pounce so remap to ?
map("n", "?", "/")
