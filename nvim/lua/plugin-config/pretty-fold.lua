-- require('pretty-fold').setup({
-- 	keep_indentation = false,
-- 	fill_char = '━',
-- 	sections = {
-- 		left = {
-- 			"━ ",
-- 			function()
-- 				return string.rep("*", vim.v.foldlevel)
-- 			end,
-- 			" ━┫",
-- 			"content",
-- 			"┣",
-- 		},
-- 		right = {
-- 			"┫ ",
-- 			"number_of_folded_lines",
-- 			": ",
-- 			"percentage",
-- 			" ┣━━",
-- 		},
-- 	},
-- })

-- require('pretty-fold').setup({
-- 	keep_indentation = false,
-- 	fill_char = '•',
-- 	sections = {
-- 		left = {
-- 			'+',
-- 			function()
-- 				return string.rep('-', vim.v.foldlevel)
-- 			end,
-- 			' ',
-- 			'content',
-- 			':',
-- 			'number_of_folded_lines',
-- 		},
-- 	},
-- })

require('pretty-fold').setup({
	keep_indentation = false,
	fill_char = '━',
	sections = {
		left = {
			'━ ',
			function()
				return string.rep('*', vim.v.foldlevel)
			end,
			-- '━ ',
			' ━┫',
			'content',
			'┣',
		},
		right = {
			'━',
			' ',
			'number_of_folded_lines',
			' ',
			'━',
		},
	},
})
