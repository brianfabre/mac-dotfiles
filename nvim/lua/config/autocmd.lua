vim.cmd([[
" no relative line number in insert mode
autocmd InsertEnter,WinLeave * if &number | set nornu | endif
autocmd InsertLeave,WinEnter * if &number | set rnu | endif
" run lua code
autocmd FileType lua map <buffer> <leader>pp :w<CR>:luafile %<CR>

" restart kitty when saving conf file
" autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep -a kitty)

" autocmd FileType stata setlocal commentstring=//\ %s
]])

-- highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
    end,
})

-- set syntax for .md
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
    pattern = { "*.md" },
    command = "set syntax=markdown",
})

-- set iskeyword+=-
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "Filetype" }, {
    pattern = { "*" },
    command = "set iskeyword+=-",
})

-- hide cursorline when in insert
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
    { "InsertLeave", "WinEnter" },
    { pattern = "*", command = "set cursorline", group = cursorGrp }
)
vim.api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- delete all marks on enter
vim.api.nvim_create_autocmd({ "BufRead" }, {
    command = ":delm a-zA-Z0-9",
})

-- deletes trailing whitespaces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

local group = vim.api.nvim_create_augroup("codegroup", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "python" },
    callback = function()
        vim.keymap.set("n", "<leader>pp", ":lua require('config/utils').RunCode()<CR>", { silent = true })
        vim.opt.foldmethod = "indent"
    end,
    group = group,
})
