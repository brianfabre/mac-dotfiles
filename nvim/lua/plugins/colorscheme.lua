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
				transparent_background = true,
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
				transparent = true,
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
			-- -- should be called later?
			-- vim.api.nvim_set_hl(0, "Folded", { fg = "#ABB2BF" })
			-- vim.api.nvim_set_hl(0, "Visual", { bg = "#A9A9A9", fg = "#282A36" })
		end,
	},
	{
		"sainnhe/sonokai",
		lazy = true,
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
}

return M
