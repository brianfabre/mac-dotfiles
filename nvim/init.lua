--//------------------------------------------//--
--//                  NEOVIM                  //--
--//          init.vim --> init.lua           //--
--//             work in progress             //--
--//------------------------------------------//--

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

require("lazy").setup({
	{
		"mhinz/vim-startify",
		config = function()
			map("n", "<leader>ss", ":Startify<cr>")
		end,
	},
	{
		"echasnovski/mini.base16",
		lazy = false,
		priority = 1000,
		config = function()
			require("mini.base16").setup({
				palette = require("mini.base16").mini_palette("#112641", "#e2e98f", 75),
				name = "minischeme",
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("plugin-config/lualine")
		end,
	},
	{
		"vimwiki/vimwiki",
		-- keys = { "<leader>ww" },
		-- event = "BufEnter *.md",
		dependencies = {
			"preservim/vim-markdown",
			"michal-h21/vim-zettel",
		},
		-- must initialize before load plugin
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "~/Documents/wiki/",
					syntax = "markdown",
					ext = ".md",
					diary_rel_path = "journal/",
					diary_index = "journal",
					diary_header = "Journal",
				},
			}
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_hl_headers = 1
			vim.g.vimwiki_auto_chdir = 1
			vim.g.vimwiki_key_mappings = { table_mappings = 0 }
		end,
	},
	{
		"preservim/vim-markdown",
		ft = {
			"vimwiki",
			"markdown",
		},
		dependencies = {
			"mzlogin/vim-markdown-toc",
			"godlygeek/tabular",
		},
		config = function()
			-- vim.cmd("setlocal syntax=markdown")
			vim.g.markdown_fenced_languages = { "python=python", "r=r" }
			vim.g.vim_markdown_autowrite = 1 -- auto-saves when entering link
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_frontmatter = 1 -- highlights yaml frontmatter
			vim.g.vim_markdown_toc_autofit = 1
			vim.g.vim_markdown_new_list_item_indent = 0 -- no indent when pressing typing 'o'
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		-- priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		-- version = "0.1.0",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("plugin-config/telescope")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				mappings = { extra = false },
			})
		end,
	},
	{
		"jiangmiao/auto-pairs",
		config = function()
			vim.g.AutoPairsShortcutFastWrap = "<c-e>"
		end,
	},
	{
		"dense-analysis/ale",
		config = function()
			vim.g.ale_fixers = {
				python = "black",
				r = "styler",
				tex = "latexindent",
				lua = "stylua",
			}
			vim.g.ale_linters = {
				python = { "flake8", "pyflakes" },
				r = "lintr",
				tex = "",
			}
			vim.g.ale_fix_on_save = 1
			vim.g.ale_completion_enabled = 1
			vim.g.ale_disable_lsp = 0
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		-- event = "InsertEnter",
		dependencies = {
			"quangnguyen30192/cmp-nvim-ultisnips",
			"hrsh7th/cmp-omni",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			require("plugin-config/nvim-cmp")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		-- keys = { "<leader>v" },
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("plugin-config/nvim-tree")
			map("n", "<leader>v", ":NvimTreeToggle<cr>")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugin-config/treesitter")
		end,
	},
	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
	},
	{
		"gbprod/substitute.nvim",
		event = "TextYankPost",
		config = function()
			require("plugin-config/substitute")
		end,
	},
	{
		"jalvesaq/Nvim-R",
		ft = "r",
	},
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.g.vimtex_quickfix_mode = 0
		end,
	},
	{
		"echasnovski/mini.indentscope",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 1,
					animation = require("mini.indentscope").gen_animation.none(),
				},
			})
		end,
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},
	{
		"SirVer/ultisnips",
		-- event = "InsertEnter",
		-- event = "BufEnter *.md",
		init = function()
			vim.g.UltiSnipsExpandTrigger = ";;"
		end,
		config = function()
			-- vim.g.UltiSnipsExpandTrigger = ";;"
			-- vim.g.UltiSnipsSnippetDirectories = "$HOME.'/.config/nvim/UltiSnips'"
			vim.g.UltiSnipsSnippetDirectories = { os.getenv("HOME") .. "/.config/nvim/UltiSnips" }
		end,
	},
	{
		"dccsillag/magma-nvim",
		ft = "stata",
		dependencies = {
			"poliquin/stata-vim",
		},
		config = function()
			require("plugin-config/magma-nvim")
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = true,
		config = function()
			require("plugin-config/dracula-nvim")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		event = "TextYankPost",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("neoclip").setup()
			map("n", "<leader>fy", ":Telescope neoclip<cr>")
		end,
	},
	{
		"echasnovski/mini.jump",
		lazy = false,
		config = function()
			require("mini.jump").setup({
				delay = {
					highlight = 50,
				},
			})
			-- vim.api.nvim_set_hl(0, "MiniJump", {
			-- 	sp = "#ff0000",
			-- 	bold = true,
			-- 	undercurl = true,
			-- })
			vim.api.nvim_set_hl(0, "MiniJump", {
				bg = "#ff0000",
				fg = "#ffffff",
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		keys = { "<leader>lg" },
		version = "*",
		config = function()
			require("plugin-config/toggleterm")
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			require("plugin-config/nvim-bqf")
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("plugin-config/zen-mode")
		end,
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				-- force_write_shada = true,
				mappings = {
					preview = false,
					delete_buf = "mda",
					next = "mw",
					prev = "mq",
				},
			})
		end,
	},
	-- { "junegunn/fzf" },
	-- { "junegunn/fzf.vim" },
	-- { "folke/tokyonight.nvim" },
	-- { "letorbi/vim-colors-modern-borland" },
	-- { "jupyter-vim/jupyter-vim" },
	-- { "s1n7ax/nvim-comment-frame" },
	-- { "norcalli/nvim-colorizer.lua" },
	-- { "glepnir/zephyr-nvim" },
	-- { "folke/zen-mode.nvim" },
})

-- }}}

-- vim command {{{
vim.cmd([[


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> FUNCTIONS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" check save status
nnoremap <leader>sa :call SaveStatus()<CR>
function! SaveStatus()
  if &modified
    echom "Unsaved"
  else
    echom "Saved"
  endif
endfunc

function! FindAll()
    call inputsave()
    let p = input('Search: ')
    call inputrestore()
    execute 'vimgrep "'.p.'" % |copen'
endfunction

nnoremap <leader>\ :call FindAll()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> COLORSCHEME <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" makes neovim/nvimtree transparent
" augroup user_colors
"   autocmd!
"   autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
"   autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
"   autocmd ColorScheme * highlight NvimTreeNormal ctermbg=NONE guibg=NONE
"   autocmd ColorScheme * highlight NvimTreeWinSeparator ctermbg=NONE guibg=NONE
" augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> VIMRC <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" type :Config to enter this init.vim
command! Config execute ":e $MYVIMRC"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> PLUGINS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""
""" FZF
""""""""""""""
""let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'border': 'rounded' } }
""let g:fzf_preview_window = ['hidden,right,50%', 'ctrl-p']
""let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-p']
""let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%'"
""let $FZF_DEFAULT_OPTS="--ansi"


""let g:fzf_colors =
""\ { 'fg':      ['fg', 'Normal'],
""  \ 'bg':      ['bg', 'Normal'],
""  \ 'hl':      ['fg', 'Comment'],
""  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
""  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
""  \ 'hl+':     ['fg', 'Statement'],
""  \ 'info':    ['fg', 'PreProc'],
""  \ 'border':  ['fg', 'Ignore'],
""  \ 'prompt':  ['fg', 'Conditional'],
""  \ 'pointer': ['fg', 'Exception'],
""  \ 'marker':  ['fg', 'Keyword'],
""  \ 'spinner': ['fg', 'Label'],
""  \ 'header':  ['fg', 'Comment'] }

""nnoremap <leader>ff <cmd>Files<cr>
""nnoremap <leader>fg <cmd>Rg<cr>
""nnoremap <leader>fc <cmd>History:<cr>
""nnoremap <leader>fb <cmd>BLines<cr>

"!{node_modules/*,.git/*}"
" -g "!{*,.csv}"

""command! -bang -nargs=* Rg
""      \   call fzf#vim#grep(
""      \   'rg --column --line-number --no-heading --glob "!*.{csv,txt}" --color=always -g "*.{md,R,do,py,lua,vim,tex}" --smart-case -- '.shellescape(<q-args>), 1,
""      \   fzf#vim#with_preview(), <bang>0)


""""""""""""""
""" jupyter
""""""""""""""
let g:jupyter_mapkeys = 0
augroup jupytermap
    au FileType python vnoremap <buffer> <silent> " :JupyterSendRange<CR>
    au FileType python nnoremap <buffer> <silent> " :JupyterSendCell<CR>
    au FileType python inoremap <buffer> <silent> ;; <esc>:JupyterSendRange<CR>
    " cycle through completion with tab
    " au FileType python inoremap <silent><expr> <Tab>
augroup END

""augroup jupytermap
   "" au FileType stata vnoremap <buffer> <silent> <localleader>sd :JupyterSendRange<CR>`>/^.<CR>
   "" au FileType stata nnoremap <buffer> <silent> <localleader>d :JupyterSendRange<CR>/^.<CR>
   "" au FileType stata nnoremap <buffer> <silent> <localleader>l :JupyterSendRange<CR>
   "" au FileType stata nnoremap <buffer> <silent> <localleader>rv :!jupyter qtconsole &<CR>
   "" au FileType stata nnoremap <buffer> <silent> <localleader>rv :!jupyter qtconsole &<CR>
   "" au FileType stata nnoremap <buffer> <silent> <localleader>rf :e! %<CR>
   "" au BufRead,BufNewFile *.do JupyterConnect
   "" " cycle through completion with tab
   "" " au FileType python inoremap <silent><expr> <Tab>
"augroup END

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
""" vim-markdown
""""""""""""""
" let g:markdown_fenced_languages = ['python=python', 'r=r']
" let g:vim_markdown_autowrite = 1            " auto-saves when entering link
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_frontmatter = 1          " highlights yaml frontmatter
" let g:vim_markdown_toc_autofit = 1
" let g:vim_markdown_new_list_item_indent = 0 " no indent when pressing typing 'o'
"" let g:vim_markdown_folding_style_pythonic = 1 " folding style


""""""""""""""
""" vim-markdown-toc
""""""""""""""
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'



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


function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

nnoremap <leader>gm :call SynGroup()<cr>

" set grep to rg
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True")



]])
-- }}}

-- options {{{
-- stylua: ignore start 
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"
vim.g.loaded_netrw = 1                                   -- disable netrw
vim.g.loaded_netrwPlugin = 1                             -- disable netrw

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
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
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.foldmethod = 'marker'

-- vim.opt.cursorline = true
-- vim.opt.laststatus = 0                                   -- hides status line

-- vim.formatoptions = 'tqj'                                -- removed 'c'
-- vim.opt.iskeyword:append("-")
-- stylua: ignore end
-- }}}

-- keymaps {{{

-- move between panes to left/bottom/top/right
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- move between buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
map("n", "<Leader>qq", ":bdelete!<CR>")
map("n", "<Leader>qa", ":%bd|e#<CR>:bnext<CR>:bd<CR>e")

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

-- quit all
map("n", "<Leader>zz", ":qa!<CR>")

-- file path
map("n", "<leader>fp", ':let @*=expand("%:p")<CR>')
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

-- always centers after c-d/c-u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- move within wrapped lines
map("n", "j", "gj")
map("n", "k", "gk")

-- faster in/outdenting
map("i", "<<", "<c-d>")
map("i", ">>", "<c-t>")

-- allow the . to execute once for each line of a visual selection
map("v", ".", ":normal .<CR>")

-- source init.lua
map("n", "<leader>so", ":luafile %<CR>")

-- resize windows
map("n", "<leader>=", ':exe "resize +2"<CR>')
map("n", "<leader>-", ':exe "resize -2"<CR>')

map("n", "<leader>po", ":w<CR>:source /Users/brian/Documents/neovim/test.lua<CR>")
-- " autocmd FileType lua map <buffer> <leader>po :w<CR>:source /Users/brian/Documents/neovim/test.lua<CR>

-- }}}

-- require lua{{{
-- require("plugin-config/colorizer")
-- require("plugin-config/tokyonight")
-- require("plugin-config/catppuccin")
-- require("plugin-config/nvim-comment-frame")

-- require("plugin-config/pretty-fold")
-- require("plugin-config/iron")

-- require('notify').setup({
-- 	stages = 'static',
-- 	timeout = 2000,
-- })
-- }}}

-- colorscheme{{{
-- vim.cmd("colorscheme dracula")
-- vim.cmd("colorscheme zephyr")
-- vim.cmd("colorscheme tokyonight-night")
-- vim.cmd("colorscheme borland")
-- vim.cmd("colorscheme catppuccin")
-- }}}

-- highlights {{{
-- vim.api.nvim_set_hl(0, "Folded", { fg = "#A9A9A9" })
-- vim.api.nvim_set_hl(0, "Visual", { fg = "#000000", bg = "#A9A9A9" })
-- }}}

-- autocommands / commands {{{
vim.cmd([[
" removes cursorline when in insert mode
" autocmd InsertLeave,WinEnter * set cursorline
" autocmd InsertEnter,WinLeave * set nocursorline
" no relative line number in insert mode
autocmd InsertEnter,WinLeave * if &number | set nornu | endif
autocmd InsertLeave,WinEnter * if &number | set rnu | endif
" run python code
autocmd FileType python map <buffer> <leader>pp :w<CR>:ter python3 %<CR>
" run lua code
autocmd FileType lua map <buffer> <leader>pp :w<CR>:!lua %<CR>
" restart kitty when saving conf file
autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep -a kitty)
" iskeyword overwritten so putting it here
autocmd BufRead, BufNewFile * set isk+=-

autocmd FileType stata setlocal commentstring=//\ %s
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
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile", "BufRead" }, {
	pattern = { "*.md" },
	command = "set syntax=markdown",
})

-- disable indentscope in startify
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "startify" },
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
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

-- }}}
