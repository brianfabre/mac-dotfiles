local M = {

    {
        "nvim-telescope/telescope.nvim",
        event = { "BufReadPre", "BufNewFile" },
        version = false, -- telescope did only one release, so use HEAD for now
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
                            height = 0.8,
                            -- width = 0.8,
                            width = 0.8,
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
                    project = {
                        theme = "dropdown",
                        order_by = "recent",
                        -- sync_with_nvim_tree = true, -- default false
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
            end, { desc = "Files" })
            vim.keymap.set("n", "<leader>sc", function()
                ts.builtin.command_history(dropdown)
            end, { desc = "Command history" })
            vim.keymap.set("n", "<leader>sv", function()
                ts.builtin.buffers(dropdown)
            end, { desc = "Buffers" })
            vim.keymap.set("n", "<leader>sg", ts.grep_fuzzy, { desc = "Grep" })
            vim.keymap.set("n", "<leader>sb", ts.builtin.current_buffer_fuzzy_find, { desc = "Buffer" })
            vim.keymap.set("n", "<leader>sh", ts.builtin.help_tags, { desc = "Help tags" })
            vim.keymap.set("n", "<leader>sm", ts.builtin.marks, { desc = "Marks" })
            vim.keymap.set("n", "<leader>sl", ts.builtin.highlights, { desc = "Highlights" })
            vim.keymap.set("n", "<leader>ss", ts.builtin.colorscheme, { desc = "Colorscheme" })

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
