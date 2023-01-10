require("colorizer").setup({
	"*", -- Highlight all files, but customize some others.
	"!python", -- Exclude vim from highlighting.
	"!tex", -- Exclude vim from highlighting.
	-- Exclusion Only makes sense if '*' is specified!
})
