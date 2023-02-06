require("echo-diagnostics").setup({
	show_diagnostic_number = true,
	show_diagnostic_source = false,
})
-- show line diagnostics automatically in hover window or echo
vim.diagnostic.config({ virtual_text = false })
vim.o.updatetime = 250
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
vim.cmd([[autocmd CursorHold * lua require('echo-diagnostics').echo_line_diagnostic()]])

vim.fn.sign_define("DiagnosticSignError", {
	texthl = "DiagnosticSignError",
	text = "",
	numhl = "DiagnosticSignError",
})

vim.fn.sign_define("DiagnosticSignWarn", {
	texthl = "DiagnosticSignWarn",
	text = "",
	numhl = "DiagnosticSignWarn",
})
vim.fn.sign_define("DiagnosticSignHint", {
	texthl = "DiagnosticSignHint",
	text = "",
	numhl = "DiagnosticSignHint",
})
vim.fn.sign_define("DiagnosticSignInfo", {
	texthl = "DiagnosticSignInfo",
	text = "",
	numhl = "DiagnosticSignInfo",
})

-- must call neodev before lspconfig
require("neodev").setup({})

-- Set up lspconfig.
require("lspconfig")["sumneko_lua"].setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		Lua = {
			format = {
				enable = false,
			},
			completion = { callSnippet = "Replace" },
			runtime = { version = "LuaJIT" },
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- require("lspconfig")["pyright"].setup({})
-- require("lspconfig").jedi_language_server.setup({})

-- vscode comp theme
vim.cmd([[
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! link CmpItemKindInterface CmpItemKindVariable
highlight! link CmpItemKindText CmpItemKindVariable
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! link CmpItemKindMethod CmpItemKindFunction
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! link CmpItemKindProperty CmpItemKindKeyword
highlight! link CmpItemKindUnit CmpItemKindKeyword
]])
