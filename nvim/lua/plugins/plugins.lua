local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local M = {

	{
		"catppuccin/nvim",
		lazy = true,
		priority = 1000,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				-- flavour = "mocha", -- latte, frappe, macchiato, mocha
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = false,
				term_colors = true,
			})
			-- vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = false,
				styles = { sidebars = "transparent", floats = "transparent" },
				on_highlights = function(hl, c)
					hl.htmlH1 = { fg = c.teal, underline = true, bold = true }
					hl.htmlH2 = { fg = c.blue, underline = true, bold = true }
					hl.htmlH3 = { fg = c.green, underline = true, bold = true }
					hl.htmlBold = { fg = c.red, bold = true }
					hl.htmlItalic = { fg = c.magenta, italic = true }
					hl.htmlBoldItalic = { fg = c.yellow, bold = true, italic = true }
					hl.htmlLink = { fg = c.orange, underline = true }
					hl.Comment = { fg = c.dark5 }
				end,
			})
			-- vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			local dracula = require("dracula")
			dracula.setup({
				transparent_bg = true, -- default false
				-- set italic comment
				italic_comment = true, -- default false
				overrides = {
					-- Examples
					-- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
					-- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
					-- Nothing = {} -- clear highlight of Nothing
					htmlH1 = { fg = dracula.colors().cyan, underline = true, bold = true },
					htmlH2 = { fg = dracula.colors().pink, underline = true, bold = true },
					htmlH3 = { fg = dracula.colors().green, underline = true, bold = true },
					htmlH4 = { fg = dracula.colors().orange, underline = true, bold = true },
					htmlH5 = { fg = dracula.colors().purple, underline = true, bold = true },
					htmlH6 = { fg = dracula.colors().yellow, underline = true, bold = true },
					htmlItalic = { fg = dracula.colors().purple, italic = true },
					htmlLink = { fg = dracula.colors().orange, underline = true },
					htmlBoldItalic = { fg = dracula.colors().green, bold = true, italic = true },
					-- Comment = { fg = dracula.colors().comment },
					Comment = { fg = "#A9A9A9", italic = true },
				},
			})

			-- tabline colors
			local colors = require("dracula").colors()
			vim.api.nvim_set_hl(0, "MiniTablineCurrent", {
				bg = colors.comment,
				fg = colors.yellow,
			})
			vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", {
				bg = colors.comment,
				fg = colors.bright_blue,
			})
			vim.api.nvim_set_hl(0, "MiniTablineHidden", {
				fg = colors.yellow,
			})
			vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", {
				fg = colors.bright_blue,
			})
			vim.api.nvim_set_hl(0, "MiniTablineVisible", {
				bg = "",
				-- fg = colors.pink,
			})
			vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", {
				bg = "",
				fg = colors.comment,
			})
			vim.cmd([[colorscheme dracula]])
			-- should be called later?
			vim.api.nvim_set_hl(0, "Folded", { fg = "#ABB2BF" })
			vim.api.nvim_set_hl(0, "Visual", { bg = "#A9A9A9", fg = "#282A36" })
			-- makes neovim/nvimtree transparent
			vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "", fg = "" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "", fg = "" })
		end,
	},
	{
		"sainnhe/sonokai",
		priority = 1000,
		config = function()
			vim.g.sonokai_style = "atlantis"
			vim.g.sonokai_better_performance = 1
		end,
	},
	{
		"echasnovski/mini.base16",
		lazy = true,
		priority = 1000,
		config = function()
			require("mini.base16").setup({
				palette = require("mini.base16").mini_palette("#112641", "#e2e98f", 75),
				-- palette = {
				-- },
				name = "minischeme",
			})
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "", bg = "" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#112641" })
		end,
	},
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
			vim.cmd([[autocmd FileType vimwiki nnoremap <CR> <cmd>silent VimwikiFollowLink<cr>]])
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
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = { "python", "markdown", "lua", "vim", "latex", "r" },
				auto_install = true,
				highlight = {
					enable = true,
					disable = { "markdown" },
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						scope_incremental = "<S-CR>",
						node_decremental = "<BS>",
					},
				},
			})
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
		"norcalli/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		init = function()
			vim.opt.termguicolors = true
		end,
		config = function()
			require("colorizer").setup({
				"*", -- Highlight all files, but customize some others.
				"!python", -- Exclude vim from highlighting.
				"!tex", -- Exclude vim from highlighting.
				-- Exclusion Only makes sense if '*' is specified!
			})
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
		config = function()
			require("neoclip").setup()
			map("n", "<leader>fy", ":Telescope neoclip<cr>", { desc = "Neoclip" })
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			-- Adapt fzf's delimiter in nvim-bqf
			require("bqf").setup({
				filter = {
					fzf = {
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
					},
				},
				preview = {
					auto_preview = true,
				},
			})
		end,
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
				plugins = {
					kitty = {
						enabled = false,
						font = "+4", -- font size increment
					},
				},
			})
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
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		lazy = true,
		enabled = true,
		config = function()
			require("notify").setup({
				stages = "static",
				timeout = 2000,
				render = "minimal",
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		cmd = "ColorizerToggle",
		-- enabled = false,
		init = function()
			vim.opt.termguicolors = true
		end,
		config = function()
			require("colorizer").setup({
				"*", -- Highlight all files, but customize some others.
				"!python", -- Exclude vim from highlighting.
				"!tex", -- Exclude vim from highlighting.
				-- Exclusion Only makes sense if '*' is specified!
			})
		end,
	},
	{
		"folke/neodev.nvim",
		-- enabled = false,
		config = function()
			require("neodev").setup({})
		end,
	},
	{
		"rlane/pounce.nvim",
		config = function()
			vim.cmd([[nmap F <cmd>Pounce<CR>]])
			vim.api.nvim_set_hl(0, "PounceMatch", {
				bg = "#ff0000",
				fg = "#ffffff",
			})
			vim.api.nvim_set_hl(0, "PounceGap", {
				bg = "#ff0000",
				fg = "#ffffff",
			})
			vim.api.nvim_set_hl(0, "PounceAccept", {
				bg = "#00FF00",
				fg = "#000000",
				bold = true,
			})
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		-- enabled = false,
		cmd = "ChatGPT",
		config = function()
			require("chatgpt").setup({
				welcome_message = "",
				openai_params = {
					max_tokens = 3000,
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"knubie/vim-kitty-navigator",
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
			-- t["zt"] = { "zt", { "250" } }
			t["zz"] = { "zz", { "100" } }
			-- t["zb"] = { "zb", { "250" } }

			require("neoscroll.config").set_mappings(t)
		end,
	},
}

return M
