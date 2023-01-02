--//------------------------------------------//--
--//                  NEOVIM                  //--
--//          init.vim --> init.lua           //--
--//             work in progress             //--
--//------------------------------------------//--

-- leader {{{
vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- }}}

-- plugins {{{
vim.cmd([[
call plug#begin('~/.local/share/nvim/plugged')

    " colorscheme
    Plug 'Mofiqul/dracula.nvim'
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'letorbi/vim-colors-modern-borland'
    " snippets
    Plug 'SirVer/ultisnips'
    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    " nvim-tree
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'kyazdani42/nvim-web-devicons'
    " markdown
    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'
    Plug 'mzlogin/vim-markdown-toc'
    " vim-wiki
    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    Plug 'michal-h21/vim-zettel'
    " Plug 'michal-h21/vimwiki-sync'
    " Plug 'mattn/calendar-vim'
    " programming
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'
    Plug 'tpope/vim-commentary'
    Plug 'dense-analysis/ale'
    " python/R/stata
    Plug 'jupyter-vim/jupyter-vim'
    Plug 'poliquin/stata-vim'
    Plug 'jalvesaq/Nvim-R'
    " latex
    Plug 'lervag/vimtex'
    Plug 'vim-autoformat/vim-autoformat'
    " completion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
    Plug 'hrsh7th/cmp-omni'
    Plug 'hrsh7th/cmp-cmdline'
    " text editing
    Plug 'jiangmiao/auto-pairs'
    Plug 'svermeulen/vim-subversive'
    Plug 'AckslD/nvim-neoclip.lua'
    Plug 'Pocco81/true-zen.nvim'
    Plug 's1n7ax/nvim-comment-frame'
    " other
    Plug 'dstein64/vim-startuptime'
    Plug 'mhinz/vim-startify'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'echasnovski/mini.jump'
    Plug 'anuvyklack/pretty-fold.nvim'
    Plug 'kevinhwang91/nvim-bqf'
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
    Plug 'nvim-lualine/lualine.nvim'
    "Plug 'rcarriga/nvim-notify'
    
call plug#end()
]])
-- }}}

-- vim command {{{
vim.cmd([[

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> FUNCTIONS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" check save status
nnoremap <leader>sa :call SaveStatus()<CR>
function! SaveStatus()
  if &modified
    echom "Unsaved"
  else
    echom "Saved"
  endif
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> COLORSCHEME <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" makes neovim/nvimtree transparent
augroup user_colors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight NvimTreeNormal ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight NvimTreeWinSeparator ctermbg=NONE guibg=NONE
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> VIMRC <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" type :Config to enter this init.vim
command! Config execute ":e $MYVIMRC"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> PLUGINS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""
""" ale
""""""""""""""
let g:ale_linters = {'python': ['flake8', 'pyflakes'], 'r': ['lintr'], 'tex': []}
let g:ale_fixers = {'python': ['black'], 'r': ['styler'], 'tex': ['latexindent'], 'lua': ['stylua']}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_disable_lsp = 0


""""""""""""""
""" autopairs
""""""""""""""
let g:AutoPairsShortcutFastWrap = '<c-e>'


""""""""""""""
""" FZF
""""""""""""""
""let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'border': 'rounded' } }
""let g:fzf_preview_window = ['hidden,right,50%', 'ctrl-p']
""let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-p']
""let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%'"
""let $FZF_DEFAULT_OPTS="--ansi"


""let g:fzf_colors =
""\ { 'fg':      ['fg', 'Normal'],
""  \ 'bg':      ['bg', 'Normal'],
""  \ 'hl':      ['fg', 'Comment'],
""  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
""  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
""  \ 'hl+':     ['fg', 'Statement'],
""  \ 'info':    ['fg', 'PreProc'],
""  \ 'border':  ['fg', 'Ignore'],
""  \ 'prompt':  ['fg', 'Conditional'],
""  \ 'pointer': ['fg', 'Exception'],
""  \ 'marker':  ['fg', 'Keyword'],
""  \ 'spinner': ['fg', 'Label'],
""  \ 'header':  ['fg', 'Comment'] }

""nnoremap <leader>ff <cmd>Files<cr>
""nnoremap <leader>fg <cmd>Rg<cr>
""nnoremap <leader>fc <cmd>History:<cr>
""nnoremap <leader>fb <cmd>BLines<cr>

"!{node_modules/*,.git/*}"
" -g "!{*,.csv}"

""command! -bang -nargs=* Rg
""      \   call fzf#vim#grep(
""      \   'rg --column --line-number --no-heading --glob "!*.{csv,txt}" --color=always -g "*.{md,R,do,py,lua,vim,tex}" --smart-case -- '.shellescape(<q-args>), 1,
""      \   fzf#vim#with_preview(), <bang>0)


""""""""""""""
""" jupyter
""""""""""""""
let g:jupyter_mapkeys = 0
augroup jupytermap
    au FileType python vnoremap <buffer> <silent> " :JupyterSendRange<CR>
    au FileType python nnoremap <buffer> <silent> " :JupyterSendCell<CR>
    au FileType python inoremap <buffer> <silent> ;; <esc>:JupyterSendRange<CR>
    " cycle through completion with tab
    " au FileType python inoremap <silent><expr> <Tab>
augroup END

augroup jupytermap
    au FileType stata vnoremap <buffer> <silent> <localleader>sd :JupyterSendRange<CR>`>/^.<CR>
    au FileType stata nnoremap <buffer> <silent> <localleader>d :JupyterSendRange<CR>/^.<CR>
    au FileType stata nnoremap <buffer> <silent> <localleader>l :JupyterSendRange<CR>
    au FileType stata nnoremap <buffer> <silent> <localleader>rv :!jupyter qtconsole &<CR>
    au FileType stata nnoremap <buffer> <silent> <localleader>rf :e! %<CR>
    au BufRead,BufNewFile *.do JupyterConnect
    " cycle through completion with tab
    " au FileType python inoremap <silent><expr> <Tab>
augroup END

""""""""""""""
""" mini.jump
""""""""""""""
hi MiniJump gui=bold,undercurl guisp=#FF0000


""""""""""""""
""" nvim-r 
""""""""""""""
let R_assign_map = '..'
let g:R_auto_start = 2
let R_csv_app = 'terminal:vd'
" let R_set_omnifunc = []
let R_auto_omni = []
let R_rconsole_height = winheight(0) / 3
let R_rconsole_width = 0

" doesnt work
au VimResized * let R_rconsole_height = winheight(0) / 3


""""""""""""""
""" nvim-tree
""""""""""""""
nnoremap <silent> <leader>v :NvimTreeToggle<cr>


""""""""""""""
""" startify
""""""""""""""
nnoremap <leader>ss :Startify<cr>


""""""""""""""
""" ulti-snips
""""""""""""""
let g:UltiSnipsExpandTrigger=";;"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']


""""""""""""""
""" vim-autoformat
""""""""""""""
" let g:python3_host_prog="/opt/homebrew/Cellar/python@3.10/3.10.6_2/bin/python3"
let g:python3_host_prog="/opt/homebrew/bin/python3"
let g:formatdef_latexindent = '"latexindent -"'


""""""""""""""
""" vim-markdown
""""""""""""""
let g:markdown_fenced_languages = ['python=python', 'r=r']
let g:vim_markdown_autowrite = 1            " auto-saves when entering link
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1          " highlights yaml frontmatter
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_new_list_item_indent = 0 " no indent when pressing typing 'o'
" let g:vim_markdown_folding_style_pythonic = 1 " folding style


""""""""""""""
""" vim-markdown
""""""""""""""
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'



""""""""""""""
""" vim-subversive
""""""""""""""
" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

""""""""""""""
""" vimtex
""""""""""""""
let g:vimtex_quickfix_mode=0


""""""""""""""
""" vimwiki
""""""""""""""
let g:vimwiki_global_ext=0
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_auto_chdir = 1
let g:vimwiki_key_mappings = { 'table_mappings': 0, } " allows ultisnips to use tab insert mode
let g:vimwiki_list = [{
            \'path': '~/Documents/wiki/',
            \'syntax': 'markdown',
            \'ext': '.md',
            \'diary_rel_path': 'journal/',
            \'diary_index': 'journal',
            \'diary_header': 'Journal',
            \'nested_syntaxes': {'python': 'python', 'r': 'r'},
            \'automatic_nested_syntaxes': 1}]


augroup filetypedetect
    au BufEnter,BufNewFile,BufRead *.md			        setlocal syntax=markdown
"	 au BufEnter,BufNewFile,BufRead ~/Documents/wiki/*	setlocal syntax=markdown
"    au BufEnter,BufNewFile,BufRead *.tex			    setlocal syntax=latex
augroup END

" let g:vimwiki_tag_format = {'pre': '\(^[ -]*tags\s*:.*\)\@<=', 'pre_mark': '', 'post_mark': '', 'sep': '>><<'}
" autocmd BufNewFile */wiki/journal/[0-9]*.md :read ~/Documents/wiki/template_diary.tpl

" complete file path for external files
inoremap <expr> <c-f> fzf#vim#complete#path('rg --files --no-ignore-vcs')


""""""""""""""
""" vim-zettel
""""""""""""""
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
let g:zettel_format = '%Y%m%d%H%M%S'
let g:zettel_options = [{"disable_front_matter": 1, "template" :  "~/Documents/wiki/template.tpl"}]
let g:vimwiki_markdown_link_ext = 1


""""""""""""""
""" vimwiki-sync
""""""""""""""
" "already declared in vimwiki settings
" let g:vimwiki_list = [{
"         \ 'path':'$HOME/Documents/wiki',
"         \ 'syntax': 'markdown',
"         \ 'ext': '.md'
" \}]
let g:sync_taskwarrior = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> EXPERIMENTAL <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -bang -nargs=* TwTodo
            \ call fzf#vim#grep(
            \ 'rg --column --no-heading --color=always --smart-case -- '.shellescape('- \[[ ]\] .+'), 1, <bang>0)

command! -bang -nargs=* Titles
            \ call fzf#vim#grep(
            "\ 'rg --column --no-heading --color=always --smart-case -- '.shellescape('title:.*'), 1, <bang>0)
            \ 'rg --column --no-heading --color=always --smart-case --glob "!*.tpl"  -- '.shellescape('title:.*'), 1, 1)


nnoremap <leader>fy :Telescope neoclip<cr>


" nnoremap <leader>zn :TZNarrow<CR>
" nnoremap <leader>zf :TZFocus<CR>
nnoremap <leader>zm :TZMinimalist<CR>
nnoremap <leader>za :TZAtaraxis<CR>


function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

nnoremap <leader>gm :call SynGroup()<cr>

" set grep to rg
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

command! -nargs=0 RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True")

]])
-- }}}

-- options {{{
-- stylua: ignore start 
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.scrolloff = 4                                    -- leaves space when scrolling
vim.opt.hlsearch = false
vim.opt.incsearch = true                                 -- search as characters are entered
vim.opt.tabstop = 4                                      -- sets tab spacing
vim.opt.shiftwidth = 4                                   -- sets tab spacing
vim.opt.expandtab = true                                 -- sets tab spacing
vim.opt.autoindent = true
vim.opt.ignorecase = true                                -- case-insensitive search
vim.opt.smartcase = true                                 -- case-insensitive search
vim.opt.conceallevel = 2                                 -- for markdown syntax
vim.opt.linebreak = true                                 -- doesnt split words
vim.opt.breakindent = true                               -- enable indentation
vim.opt.breakindentopt = { 'shift:4', 'sbr', 'list:-1' } -- indent by an additional 4 characters on wrapped line
vim.opt.showbreak = '>'                                  -- append '>>' to indent
vim.opt.swapfile = false
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.laststatus = 0                                   -- hides status line
vim.opt.foldmethod = 'marker'

-- vim.opt.cursorline = true

-- vim.formatoptions = 'tqj'                                -- removed 'c'
-- vim.opt.iskeyword:append("-")
-- stylua: ignore end
-- }}}

-- keymaps {{{
-- function
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- move between panes to left/bottom/top/right
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- move between buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
map("n", "<Leader>qq", ":bdelete!<CR>")
map("n", "<Leader>qa", ":%bd|e#<CR>:bnext<CR>:bd<CR>e")

-- move line/down
map("n", "<S-Up>", ":m-2<CR>")
map("n", "<S-Down>", ":m+<CR>")
map("v", "<S-Up>", ":m '<-2<CR>gv=gv")
map("v", "<S-Down>", ":m '>+1<CR>gv=gv")

-- copy to clipboard
map("v", "<Leader>y", '"*y')

-- no register for x
map("n", "x", '"_x')

-- leave insert mode
map("i", "jk", "<esc>")

-- quit all
map("n", "<Leader>zz", ":qa!<CR>")

-- file path
map("n", "<leader>fp", ':let @*=expand("%:p")<CR>')
map("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

-- always centers after c-d/c-u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- move within wrapped lines
map("n", "j", "gj")
map("n", "k", "gk")

-- faster in/outdenting
map("i", "<<", "<c-d>")
map("i", ">>", "<c-t>")

-- allow the . to execute once for each line of a visual selection
map("v", ".", ":normal .<CR>")

-- source init.lua
map("n", "<leader>so", ":luafile %<CR>")

-- resize windows
map("n", "<leader>=", ':exe "resize +2"<CR>')
map("n", "<leader>-", ':exe "resize -2"<CR>')

map("n", "<leader>po", ":w<CR>:source /Users/brian/Documents/neovim/test.lua<CR>")
-- " autocmd FileType lua map <buffer> <leader>po :w<CR>:source /Users/brian/Documents/neovim/test.lua<CR>

-- }}}

-- require lua{{{
require("plugin-config/treesitter")
require("plugin-config/nvim-tree")
require("plugin-config/colorizer")
require("plugin-config/dracula-nvim")
require("plugin-config/nvim-cmp")
require("plugin-config/tokyonight")
require("plugin-config/catppuccin")
require("plugin-config/telescope")
require("plugin-config/neoclip")
require("plugin-config/mini-jump")
require("plugin-config/nvim-comment-frame")
require("plugin-config/pretty-fold")
require("plugin-config/nvim-bqf")
require("plugin-config/toggleterm")
require("plugin-config/lualine")

require("true-zen").setup({})
-- require('notify').setup({
-- 	stages = 'static',
-- 	timeout = 2000,
-- })
-- }}}

-- colorscheme{{{
vim.cmd("colorscheme dracula")
-- vim.cmd('colorscheme tokyonight-night')
-- vim.cmd('dracula')
-- vim.cmd('borland')
-- vim.cmd('catppuccin')
-- }}}

-- highlights {{{
vim.api.nvim_set_hl(0, "Folded", { fg = "#A9A9A9" })
vim.api.nvim_set_hl(0, "Visual", { fg = "#000000", bg = "#A9A9A9" })
-- }}}

-- autocommands / commands {{{
vim.cmd([[
" removes cursorline when in insert mode
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline
" no relative line number in insert mode
autocmd InsertEnter,WinLeave * if &number | set nornu | endif
autocmd InsertLeave,WinEnter * if &number | set rnu | endif
" sets width when using 'gq'
au BufRead,BufNewFile *.tex setlocal textwidth=100
au BufRead,BufNewFile *.tex setlocal formatoptions-=t
" highlights text on yank
autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }
" run python code
autocmd FileType python map <buffer> <leader>pp :w<CR>:ter python3 %<CR>
" run lua code
autocmd FileType lua map <buffer> <leader>pp :w<CR>:!lua %<CR>
" autocmd FileType lua map <buffer> <leader>po :w<CR>:source /Users/brian/Documents/neovim/test.lua<CR>
" restart kitty when saving conf file
autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep -a kitty)
" iskeyword overwritten so putting it here
autocmd BufRead, BufNewFile * set isk+=-

autocmd FileType stata setlocal commentstring=//\ %s
]])

vim.cmd("command! -nargs=+ NewGrep execute 'silent grep! <args>' | copen")

-- }}}
