local cmp = require("cmp")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
		-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		-- ['<CR>'] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping({
			-- c = function()
			--     if cmp.visible() then
			--         cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			--     else
			--         cmp.complete()
			--     end
			-- end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
					vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
				else
					fallback()
				end
			end,
		}),
		["<S-Tab>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				else
					cmp.complete()
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
					return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
				else
					fallback()
				end
			end,
			s = function(fallback)
				if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
					return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
				else
					fallback()
				end
			end,
		}),

		["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
		["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
		["<CR>"] = cmp.mapping({
			i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
			-- c = function(fallback)
			--     if cmp.visible() then
			--         cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
			--     else
			--         fallback()
			--     end
			-- end
		}),
	}),
	sources = cmp.config.sources({
        { name = "omni", keyword_length = 0 },
		{ name = "nvim_lsp" },
		{ name = "ultisnips" }, -- For ultisnips users
		-- { name = "omni", trigger_characters = { "$" } },
	}, {
		-- { name = 'buffer' },
		-- { name = "omni" },
	}),
	-- this disables completion when cursor in comment
	-- currently disabled due to errors
	-- enabled = function()
	-- 	local context = require("cmp.config.context")
	-- 	return not (context.in_treesitter_capture("comment") or context.in_syntax_group("Comment"))
	-- end,
})

-- local cmp_ultisnips = require("cmp_nvim_ultisnips")
-- cmp_ultisnips.setup({
-- 	filetype_source = "ultisnips_default",
-- })

-- disables completion in markdown
local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
	pattern = { "markdown", "sh" },
	callback = function()
		require("cmp").setup.buffer({ enabled = false })
	end,
})

-- cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

-- Set up lspconfig.
require("lspconfig")["sumneko_lua"].setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		Lua = {
            completion = {
                enable = false,
            },
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
