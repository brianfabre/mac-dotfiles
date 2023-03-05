local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local M = {

	{
		"echasnovski/mini.tabline",
		config = function()
			require("mini.tabline").setup({})
		end,
	},
	{
		"vimwiki/vimwiki",
		-- must initialize before load plugin
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "/Volumes/MacAsahi/Documents/wiki/",
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
		config = function()
			vim.cmd([[
            autocmd FileType vimwiki nnoremap <CR> <cmd>silent VimwikiFollowLink<cr>
            " complete file path for external files
            inoremap <expr> <c-f> fzf#vim#complete#path('rg --files --no-ignore-vcs')
            ]])
		end,
	},
	{
		"preservim/vim-markdown",
		ft = {
			"vimwiki",
			"markdown",
		},
		-- all vimwiki-related dependencies here
		-- must load vimwiki first
		dependencies = {
			"michal-h21/vim-zettel",
			"mzlogin/vim-markdown-toc",
			"godlygeek/tabular",
		},
		config = function()
			-- vim.cmd("setlocal syntax=markdown")
			vim.g.markdown_fenced_languages = { "python=python", "r=r" }
			vim.g.vim_markdown_autowrite = 1 -- auto-saves when entering link
			vim.g.vim_markdown_folding_disabled = 1
			-- vim.g.vim_markdown_folding_level = 2
			vim.g.vim_markdown_frontmatter = 1 -- highlights yaml frontmatter
			vim.g.vim_markdown_toc_autofit = 1
			vim.g.vim_markdown_new_list_item_indent = 0 -- no indent when pressing typing 'o'
			vim.g.vmt_fence_text = "TOC"
			vim.g.vmt_fence_closing_text = "/TOC"

			vim.cmd([[
            let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
            let g:zettel_format = '%Y%m%d%H%M%S'
            let g:zettel_options = [{"disable_front_matter": 1, "template" :  "~/Documents/wiki/template.tpl"}]
            let g:vimwiki_markdown_link_ext = 1
            ]])
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			mappings = { extra = false },
		},
	},
	{
		"jiangmiao/auto-pairs",
		config = function()
			vim.g.AutoPairsShortcutFastWrap = "<c-e>"
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
			require("substitute").setup({})
			vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
			vim.keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
			vim.keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
			vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
		end,
	},
	{
		"jalvesaq/Nvim-R",
		ft = "r",
		config = function()
			vim.cmd([[
            let R_assign_map = '..'
            let g:R_auto_start = 2
            let R_csv_app = 'terminal:vd'
            " let R_set_omnifunc = []
            let R_auto_omni = []
            let R_rconsole_height = winheight(0) / 3
            let R_rconsole_width = 0

            " au VimResized * let R_rconsole_height = winheight(0) / 3
            ]])
		end,
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
			-- disable indentscope in startify, markdown
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = { "alpha", "markdown", "lazy" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})

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
		-- enabled = false,
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
		"AckslD/nvim-neoclip.lua",
		event = "TextYankPost",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {},
		config = function()
			map("n", "<leader>fy", ":Telescope neoclip<cr>", { desc = "Neoclip" })
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		opts = {
			filter = {
				fzf = {
					extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
				},
			},
			preview = {
				auto_preview = true,
			},
		},
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
					-- height and width can be:
					-- * an absolute number of cells when > 1
					-- * a percentage of the width / height of the editor when <= 1
					-- * a function that returns the width or the height
					width = 80, -- width of the Zen window
					height = 0.9, -- height of the Zen window
					-- by default, no options are changed for the Zen window
					-- uncomment any of the options below, or add other vim.wo options you want to apply
					options = {
						-- signcolumn = "no", -- disable signcolumn
						number = false, -- disable number column
						relativenumber = false, -- disable relative numbers
						cursorline = false, -- disable cursorline
						cursorcolumn = false, -- disable cursor column
						-- foldcolumn = "0", -- disable fold column
						-- list = false, -- disable whitespace characters
					},
				},
			})
		end,
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				mappings = {
					preview = false,
					delete_buf = "mda",
					next = "mw",
					prev = "mq",
				},
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		opts = {},
	},
	{
		"rcarriga/nvim-notify",
		lazy = true,
		enabled = true,
		opts = {
			stages = "static",
			timeout = 2000,
			render = "minimal",
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		init = function()
			vim.opt.termguicolors = true
		end,
		opts = {},
	},
	{
		"folke/neodev.nvim",
		-- enabled = false,
		opts = {},
	},
	{
		"rlane/pounce.nvim",
		config = function()
			vim.cmd([[nmap F <cmd>Pounce<CR>]])
			-- vim.api.nvim_set_hl(0, "PounceMatch", {
			-- 	bg = "#ff0000",
			-- 	fg = "#ffffff",
			-- })
			-- vim.api.nvim_set_hl(0, "PounceGap", {
			-- 	bg = "#ff0000",
			-- 	fg = "#ffffff",
			-- })
			-- vim.api.nvim_set_hl(0, "PounceAccept", {
			-- 	bg = "#00FF00",
			-- 	fg = "#000000",
			-- 	bold = true,
			-- })
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		-- enabled = false,
		cmd = "ChatGPT",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			welcome_message = "",
			openai_params = {
				max_tokens = 3000,
			},
		},
	},
	{
		"knubie/vim-kitty-navigator",
		enabled = false,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				easing_function = "sine",
			})
			local t = {}
			-- Syntax: t[keys] = {function, {function arguments}}
			t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } }
			t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100" } }
			-- t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } }
			-- t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } }
			-- t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
			-- t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
			t["zt"] = { "zt", { "100" } }
			t["zz"] = { "zz", { "100" } }
			t["zb"] = { "zb", { "100" } }

			require("neoscroll.config").set_mappings(t)
		end,
	},
}

return M
