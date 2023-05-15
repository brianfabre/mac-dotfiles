local M = {

    {
        "hrsh7th/nvim-cmp",
        event = { "BufReadPre", "BufNewFile" },
        keys = ":",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-omni",
            "hrsh7th/cmp-cmdline",
            "quangnguyen30192/cmp-nvim-ultisnips",
        },
        config = function()
            local kind_icons = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
            }

            local t = function(str)
                return vim.api.nvim_replace_termcodes(str, true, true, true)
            end

            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered({
                    -- 	border = "single",
                    -- 	col_offset = -1,
                    -- }),
                    documentation = cmp.config.window.bordered({
                        border = "single",
                    }),
                },
                formatting = {
                    format = function(entry, vim_item)
                        local prsnt, lspkind = pcall(require, "lspkind")
                        if not prsnt then
                            -- from kind_icons array
                            -- concatenates the icons with the name of the item kind
                            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
                        else
                            -- From lspkind
                            return lspkind.cmp_format()
                        end
                        -- Source
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            ultisnips = "[UltiSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        })[entry.source.name]

                        vim_item.abbr = string.sub(vim_item.abbr, 1, 30)

                        return vim_item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<Tab>"] = cmp.mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                            else
                                cmp.complete()
                            end
                        end,
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
                    ["<Down>"] = cmp.mapping(
                        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                        { "i" }
                    ),
                    ["<Up>"] = cmp.mapping(
                        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                        { "i" }
                    ),
                    ["<CR>"] = cmp.mapping({
                        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false }),
                    }),
                }),
                sources = cmp.config.sources({
                    { name = "ultisnips" }, -- For ultisnips users
                    {
                        name = "nvim_lsp",
                        entry_filter = function(entry)
                            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                        end,
                    },
                    { name = "omni" },
                    { name = "buffer" },
                    { name = "path" },
                }, {
                    -- { name = 'buffer' },
                    -- { name = "omni", trigger_characters = { "$" } },
                }),
                view = {
                    entries = { name = "custom", selection_order = "near_cursor" },
                },
                -- disables completion when cursor in comment
                -- disabled because introduces bug
                -- enabled = function()
                -- 	-- disable completion in comments
                -- 	local context = require("cmp.config.context")
                -- 	-- keep command mode completion enabled when cursor is in a comment
                -- 	if vim.api.nvim_get_mode().mode == "c" then
                -- 		return true
                -- 	else
                -- 		return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                -- 	end
                -- end,
            })

            -- local cmp_ultisnips = require("cmp_nvim_ultisnips")
            -- cmp_ultisnips.setup({
            -- 	filetype_source = "ultisnips_default",
            -- })

            cmp.setup.filetype("python", {
                sources = cmp.config.sources({
                    { name = "ultisnips" },
                    {
                        name = "nvim_lsp",
                        entry_filter = function(entry)
                            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                        end,
                    },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })

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

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
        end,
    },
}

return M
