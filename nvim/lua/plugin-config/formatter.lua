local stylua = function()
	return {
		exe = "stylua",
		args = {
			"--config-path",
			"~/.config/nvim/stylua.toml",
			"-",
		},
		stdin = true,
	}
end

local black = function()
	return {
		exe = "black",
		args = { "-" },
		stdin = true,
	}
end

local latexindent = function()
	return {
		exe = "latexindent",
		args = { "" },
		stdin = true,
	}
end

local styler = function()
	return {
		exe = "R",
		args = {
			"--slave",
			"--no-restore",
			"--no-save",
			"-e",
			"'con <- file(\"stdin\"); styler::style_text(readLines(con)); close(con)'",
			"2>/dev/null",
		},
		stdin = true,
	}
end

require("formatter").setup({
	-- logging = true,
	filetype = {
		lua = { stylua },
		python = { black },
		r = { styler },
		tex = { latexindent },
	},
})
