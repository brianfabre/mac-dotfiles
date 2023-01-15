builtin = require("telescope.builtin")

local get_dir = function()
	opts = opts or {}
	-- get the path to Zettelkasen
	local dir = vim.g.zettel_dir
	local dir = false
	if not dir then
		vim.fn["zettel#vimwiki#initialize_wiki_number"]()
		dir = vim.fn["vimwiki#vars#get_wikilocal"]("path")
	end
	if not dir then
		echo("Cannot find your Zettelkasten. Is the g:zettel_dir variable set?")
		return false
	end
end

local find_notes = function()
	require("telescope.builtin").grep_string({
		prompt_title = "Find Notes",
		cwd = dir,
		layout_config = { preview_width = 0.5, width = 0.8 },
		shorten_path = true,
		word_match = "-w",
		only_sort_text = true,
		search = "",
	})
end

vim.keymap.set("n", "<leader>fn", find_notes, {})
