----------------
--   NEOVIM   --
----------------

-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    change_detection = {
        notify = false,
    },
})

-- highlights
-- set spell
vim.api.nvim_set_hl(0, "SpellBad", {
    bg = "#ff0000",
    fg = "#ffffff",
})

-- require
require("bk/run_code") -- runs python code in new split
-- require("bk/autohide_tabline") -- hides tabline when only one buffer (dont need with bufferline)
require("config/options")
require("config/autocmd")
require("config/keymaps")

-- colorscheme
-- vim.cmd([[colorscheme dracula]])
vim.cmd([[colorscheme tokyonight]])
-- vim.cmd([[colorscheme nordic]])
-- vim.cmd([[colorscheme catppuccin]])
-- vim.cmd([[colorscheme sonokai]])
-- vim.cmd([[colorscheme vscode]])

-- functions
vim.cmd([[
function! FindAll()
  call inputsave()
  let p = input('Search: ')
  call inputrestore()
  execute 'vimgrep "'.p.'" % |copen'
endfunction
]])
vim.keymap.set("n", "<leader>\\", ":call FindAll()<CR>", { silent = true, desc = "QuickFix search" })
