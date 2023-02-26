local M = {

	{
		"nvim-telescope/telescope.nvim",
		-- version = "0.1.0",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local borderchars = {
				prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			}
			local borderchars_dropdown = {
				prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
				preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			}

			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "%.csv", "%.txt", "%.xml" },
					mappings = {
						i = {
							["<C-p>"] = require("telescope.actions.layout").toggle_preview,
							["<esc>"] = actions.close,
							["<C-o>"] = path_link,
						},
						n = {
							-- ["<C-o>"] = function(prompt_bufnr) end,
							["<C-o>"] = path_link,
						},
					},
					layout_config = {
						horizontal = {
							-- height = 0.6,
							height = 0.99,
							-- width = 0.8,
							width = 0.99,
							preview_width = 0.5,
						},
					},
					preview = {
						-- hide_on_startup = true, -- hide previewer when picker starts
					},
					borderchars = borderchars,
					-- ripgrep_arguments = {
					-- 	"rg",
					-- 	"--hidden",
					-- 	"--no-heading",
					-- 	"--with-filename",
					-- 	"--line-number",
					-- 	"--column",
					-- 	"--smart-case",
					-- },
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("neoclip")

			-- mappings
			local ts = {
				builtin = require("telescope.builtin"),
				grep_fuzzy = function()
					require("telescope.builtin").grep_string({
						prompt_title = "FZF",
						shorten_path = true,
						word_match = "-w",
						only_sort_text = true,
						search = "",
					})
				end,
			}

			local dropdown = require("telescope.themes").get_dropdown({
				borderchars = borderchars_dropdown,
				width = 0.4,
				previewer = false,
				-- prompt_title = false,
				preview_title = false,
			})

			local themes = require("telescope.themes")

			vim.keymap.set("n", "<leader>ff", function()
				ts.builtin.find_files(dropdown)
				-- ts.builtin.find_files(themes.get_ivy())
			end, { desc = "Files" })
			vim.keymap.set("n", "<leader>fc", function()
				ts.builtin.command_history(dropdown)
			end, { desc = "Command history" })
			vim.keymap.set("n", "<leader>fv", function()
				ts.builtin.buffers(dropdown)
			end, { desc = "Buffers" })
			vim.keymap.set("n", "<leader>fg", ts.grep_fuzzy, { desc = "Grep" })
			vim.keymap.set("n", "<leader>fb", ts.builtin.current_buffer_fuzzy_find, { desc = "Buffer search" })
			-- vim.keymap.set("n", "<leader>fc", ts.builtin.command_history, {})
			vim.keymap.set("n", "<leader>fh", ts.builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set("n", "<leader>fm", ts.builtin.marks, { desc = "Marks" })
			vim.keymap.set("n", "<leader>fl", ts.builtin.highlights, { desc = "Highlights" })
			vim.keymap.set("n", "<leader>fs", ts.builtin.colorscheme, { desc = "Colorscheme" })
			vim.keymap.set("n", "<leader>ft", ":ChatGPT<CR>", { desc = "ChatGPT" })

			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>ff",
			-- 	"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
			-- 	opts
			-- )
		end,
	},
}

return M
