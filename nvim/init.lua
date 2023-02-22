----------------
--   NEOVIM   --
----------------

-- leader {{{
vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- }}}

-- functions{{{
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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
vim.keymap.set("n", "<leader>qf", close_float, { silent = true, desc = "Close float" })
-- }}}

-- lazy.nvim {{{

-- bootstrap{{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- }}}

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})
-- }}}

-- vim command {{{
vim.cmd([[


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> FUNCTIONS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! FindAll()
    call inputsave()
    let p = input('Search: ')
    call inputrestore()
    execute 'vimgrep "'.p.'" % |copen'
endfunction


""""""""""""""
""" nvim-r
""""""""""""""
let R_assign_map = '..'
let g:R_auto_start = 2
let R_csv_app = 'terminal:vd'
" let R_set_omnifunc = []
let R_auto_omni = []
let R_rconsole_height = winheight(0) / 3
let R_rconsole_width = 0

" doesnt work
au VimResized * let R_rconsole_height = winheight(0) / 3


""""""""""""""
""" vimwiki
""""""""""""""
" complete file path for external files
inoremap <expr> <c-f> fzf#vim#complete#path('rg --files --no-ignore-vcs')


""""""""""""""
""" vim-zettel
""""""""""""""
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
let g:zettel_format = '%Y%m%d%H%M%S'
let g:zettel_options = [{"disable_front_matter": 1, "template" :  "~/Documents/wiki/template.tpl"}]
let g:vimwiki_markdown_link_ext = 1


" function! SynGroup()
"     let l:s = synID(line('.'), col('.'), 1)
"     echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
" endfun
" nnoremap <leader>gm :call SynGroup()<cr>

" set grep to rg
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

" command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True")

]])
-- }}}

-- options {{{
-- stylua: ignore start
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"
vim.g.loaded_netrw = 1                                   -- disable netrw
vim.g.loaded_netrwPlugin = 1                             -- disable netrw

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.pumheight = 7
-- vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.mouse = 'a'
vim.opt.scrolloff = 4                                    -- leaves space when scrolling
vim.opt.hlsearch = false
vim.opt.incsearch = true                                 -- search as characters are entered
vim.opt.tabstop = 4                                      -- sets tab spacing
vim.opt.shiftwidth = 4                                   -- sets tab spacing
vim.opt.expandtab = true                                 -- sets tab spacing
vim.opt.autoindent = true
vim.opt.ignorecase = true                                -- case-insensitive search
vim.opt.smartcase = true                                 -- case-insensitive search
vim.opt.conceallevel = 2                                 -- for markdown syntax
vim.opt.linebreak = true                                 -- doesnt split words
vim.opt.breakindent = true                               -- enable indentation
vim.opt.breakindentopt = { 'shift:4', 'sbr', 'list:-1' } -- indent by an additional 4 characters on wrapped line
vim.opt.showbreak = '>'                                  -- append '>>' to indent
vim.opt.swapfile = false
vim.opt.completeopt = { 'noselect' }
vim.opt.foldmethod = 'marker'

-- ## not in use ##
-- vim.opt.cmdheight = 0
-- vim.opt.autochdir = true
-- vim.opt.cursorline = true
-- vim.opt.laststatus = 0                                   -- hides status line
-- vim.formatoptions = 'tqj'                                -- removed 'c'
-- stylua: ignore end
-- }}}

-- keymaps {{{

-- move between panes to left/bottom/top/right
-- map("n", "<C-h>", "<C-w>h")
-- map("n", "<C-l>", "<C-w>l")
-- map("n", "<C-j>", "<C-w>j")
-- map("n", "<C-k>", "<C-w>k")

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
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- move within wrapped lines
-- map("n", "j", "gj")
-- map("n", "k", "gk")

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

map("n", "<leader>\\", ":call FindAll()<CR>", { desc = "QuickFix search" })

-- }}}

-- autocommands / commands {{{
vim.cmd([[
" no relative line number in insert mode
autocmd InsertEnter,WinLeave * if &number | set nornu | endif
autocmd InsertLeave,WinEnter * if &number | set rnu | endif
" run lua code
autocmd FileType lua map <buffer> <leader>pp :w<CR>:luafile %<CR>

" run code
" autocmd FileType * map <leader>po :w<CR>:luafile ~/.config/nvim/lua/robust/test.lua<CR>
" restart kitty when saving conf file
autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep -a kitty)

" autocmd FileType stata setlocal commentstring=//\ %s
]])

-- -- set colorscheme in vimwiki
-- vim.api.nvim_create_autocmd("Filetype", {
-- 	group = vim.api.nvim_create_augroup("colorscheme", { clear = true }),
-- 	pattern = { "vimwiki", "tex" },
-- 	command = "colorscheme dracula",
-- })

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

-- autosave
-- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
-- 	callback = function()
-- 		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
-- 			vim.api.nvim_command("silent update")
-- 		end
-- 	end,
-- })

-- }}}

-- highlights{{{
-- set spell
vim.api.nvim_set_hl(0, "SpellBad", {
	bg = "#ff0000",
	fg = "#ffffff",
})

-- }}}

-- require {{{

-- runs python code in new split
require("bk/run_code")
-- hides tabline when only one buffer
require("bk/autohide_tabline")

-- }}}

-- other{{{
-- vim.opt.runtimepath:append("/Users/brian/Documents/neovim/lua/")
-- }}}

-- vim.cmd([[colorscheme dracula]])
-- vim.cmd([[colorscheme tokyonight-night]])
-- vim.cmd([[colorscheme catppuccin]])
vim.cmd([[colorscheme sonokai]])
