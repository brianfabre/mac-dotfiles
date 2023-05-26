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

-- windows
map("n", "<leader>wo", "<C-W>p", { desc = "other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "split window right" })

-- move between buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
map("n", "<Leader>qq", ":bp | bd! #<CR>", { desc = "quit buffer" })
map("n", "<Leader>qa", ":%bd|e#<CR>:bnext<CR>:bd<CR>e", { desc = "quit all other buffers" })

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
map("n", "<leader>k", ":update<CR>", { desc = "save" })

-- quit all
map("n", "<leader>qp", ":qa!<CR>", { desc = "quit neovim" })

-- file path
map("n", "<leader>cw", ":lua print(vim.fn.getcwd())<CR>", { desc = "echo CWD" })
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { desc = "set as working dir" })
map("n", "<leader>cp", ':let @+=expand("%:p")<CR>', { desc = "path to clipboard" })

-- always centers after c-d/c-u
-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")

-- faster in/outdenting
map("i", "<<", "<c-d>")
map("i", ">>", "<c-t>")

-- allow the . to execute once for each line of a visual selection
map("v", ".", ":normal .<CR>")

-- open lazy.nvim
map("n", "<leader>l", ":Lazy<CR>", { desc = "lazy.nvim" })

-- open nvim config
map("n", "<leader>oc", ":e $MYVIMRC<CR>", { desc = "config" })

-- resize windows
map("n", "<leader>=", ':exe "resize +2"<CR>', { desc = "win size increase" })
map("n", "<leader>-", ':exe "resize -2"<CR>', { desc = "win size decrease" })

-- / is used by pounce so remap to ?
map("n", "?", "/")

-- ui stuff
map("n", "<leader>us", ":set invspell<CR>", { desc = "toggle spelling" })
map("n", "<leader>uw", ":set wrap!<CR>", { desc = "toggle word wrap" })

-- fastwrap
map("i", "<C-e>", "<esc>lxep<esc>i")
