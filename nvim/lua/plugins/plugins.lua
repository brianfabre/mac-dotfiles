local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local M = {

    {
        "vimwiki/vimwiki",
        cmd = "VimwikiIndex",
        keys = "<space>ww",
        -- event = "VeryLazy",
        -- must initialize before load plugin
        init = function()
            vim.g.vimwiki_list = {
                {
                    path = "/Volumes/Bob/wiki/",
                    syntax = "markdown",
                    ext = ".md",
                    diary_rel_path = "journal/",
                    diary_index = "journal",
                    diary_header = "Journal",
                },
            }
            vim.g.vimwiki_global_ext = 0
            vim.g.vimwiki_hl_headers = 1
            vim.g.vimwiki_auto_chdir = 1
            vim.g.vimwiki_key_mappings = { table_mappings = 0 }
        end,
        config = function()
            vim.cmd([[
            autocmd FileType vimwiki nnoremap <CR> <cmd>silent VimwikiFollowLink<cr>
            " complete file path for external files
            inoremap <expr> <c-f> fzf#vim#complete#path('rg --files --no-ignore-vcs')
            ]])
        end,
    },
    {
        "preservim/vim-markdown",
        ft = {
            "vimwiki",
            "markdown",
        },
        -- all vimwiki-related dependencies here
        -- must load vimwiki first
        dependencies = {
            "godlygeek/tabular",
        },
        config = function()
            -- vim.cmd("setlocal syntax=markdown")
            vim.g.markdown_fenced_languages = { "python=python", "r=r" }
            vim.g.vim_markdown_autowrite = 1 -- auto-saves when entering link
            vim.g.vim_markdown_folding_disabled = 1
            -- vim.g.vim_markdown_folding_level = 2
            vim.g.vim_markdown_frontmatter = 1 -- highlights yaml frontmatter
            vim.g.vim_markdown_toc_autofit = 1
            vim.g.vim_markdown_new_list_item_indent = 0 -- no indent when pressing typing 'o'
        end,
    },
    {
        "michal-h21/vim-zettel",
        ft = {
            "vimwiki",
            "markdown",
        },
        config = function()
            vim.cmd([[
            let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
            let g:zettel_format = '%Y%m%d%H%M%S'
            let g:zettel_options = [{"disable_front_matter": 1, "template" :  "/Volumes/Bob/wiki/template.tpl"}]
            let g:vimwiki_markdown_link_ext = 1
            ]])
        end,
    },
    {
        "mzlogin/vim-markdown-toc",
        ft = {
            "vimwiki",
            "markdown",
        },
        config = function()
            vim.g.vmt_fence_text = "TOC"
            vim.g.vmt_fence_closing_text = "/TOC"
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            mappings = { extra = false },
        },
        -- config = function()
        --     require("Comment").setup(opts)
        --     map("n", "<leader>/", ":normal! gcc<cr>", { desc = "toggle comment line" })
        --     map(
        --         "v",
        --         "<leader>/",
        --         "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        --         { desc = "toggle comment selection" }
        --     )
        -- end,
    },
    -- {
    --     "jiangmiao/auto-pairs",
    --     event = "VeryLazy",
    --     config = function()
    --         vim.g.AutoPairsShortcutFastWrap = "<c-e>"
    --     end,
    -- },
    {
        "gbprod/substitute.nvim",
        event = "TextYankPost",
        config = function()
            require("substitute").setup({})
            vim.keymap.set("n", "s", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
            vim.keymap.set("n", "ss", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
            vim.keymap.set("n", "S", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
            vim.keymap.set("x", "s", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
        end,
    },
    {
        "jalvesaq/Nvim-R",
        ft = "r",
        config = function()
            vim.cmd([[
            let R_assign_map = '..'
            let g:R_auto_start = 2
            let R_csv_app = 'terminal:vd'
            " let R_set_omnifunc = []
            let R_auto_omni = []
            let R_rconsole_height = winheight(0) / 3
            let R_rconsole_width = 0

            " au VimResized * let R_rconsole_height = winheight(0) / 3
            ]])
        end,
    },
    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.g.vimtex_quickfix_mode = 0
            vim.cmd([[
                let g:vimtex_compiler_latexmk = {
                \ 'executable' : 'latexmk',
                \ 'options' : [
                \   '-xelatex',
                \   '-file-line-error',
                \   '-synctex=1',
                \   '-interaction=nonstopmode',
                \ ],
                \}
            ]])
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- char = "▏",
            char = "│",
            filetype_exclude = { "help", "alpha", "markdown", "neo-tree", "lazy" },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
    {
        "AckslD/nvim-neoclip.lua",
        event = "TextYankPost",
        opts = {},
        config = function()
            map("n", "<leader>sy", ":Telescope neoclip<cr>", { desc = "Neoclip" })
        end,
    },
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {
            filter = {
                fzf = {
                    extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
                },
            },
            preview = {
                auto_preview = true,
            },
        },
    },
    {
        "chentoast/marks.nvim",
        keys = "m",
        config = function()
            require("marks").setup({
                mappings = {
                    preview = false,
                    delete_buf = "mda",
                    next = "mw",
                    prev = "mq",
                },
            })
        end,
    },
    {
        "kylechui/nvim-surround",
        event = { "BufReadPre", "BufNewFile" },
        version = "*",
        opts = {},
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
        enabled = true,
        opts = {
            stages = "static",
            timeout = 2000,
            render = "minimal",
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        init = function()
            vim.opt.termguicolors = true
        end,
        opts = {},
    },
    {
        "rlane/pounce.nvim",
        keys = {
            { "/", mode = { "n", "x", "o" }, desc = "pounce" },
        },
        config = function()
            vim.cmd([[nmap / <cmd>Pounce<CR>]])
            vim.api.nvim_set_hl(0, "PounceMatch", {
                bg = "#ff0000",
                fg = "#ffffff",
            })
            vim.api.nvim_set_hl(0, "PounceGap", {
                bg = "#ff0000",
                fg = "#ffffff",
            })
            vim.api.nvim_set_hl(0, "PounceAccept", {
                bg = "#00FF00",
                fg = "#000000",
                bold = true,
            })
        end,
    },
}

return M
