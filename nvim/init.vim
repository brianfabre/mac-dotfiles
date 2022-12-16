let mapleader=" "
let maplocalleader = ','

call plug#begin('~/.local/share/nvim/plugged')

    " colorscheme
    Plug 'Mofiqul/dracula.nvim'
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    " snippets
    Plug 'SirVer/ultisnips'
    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " nvim-tree
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'kyazdani42/nvim-web-devicons'
    " markdown
    Plug 'preservim/vim-markdown'
    Plug 'godlygeek/tabular'
    Plug 'mzlogin/vim-markdown-toc'
    " vim-airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " vim-wiki
    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    Plug 'michal-h21/vim-zettel'
    Plug 'michal-h21/vimwiki-sync'
    Plug 'mattn/calendar-vim'
    " programming
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'tpope/vim-commentary'
    Plug 'jiangmiao/auto-pairs'
    Plug 'dense-analysis/ale'
    " python/R
    Plug 'jupyter-vim/jupyter-vim'
    Plug 'jalvesaq/Nvim-R'
    " latex
    Plug 'lervag/vimtex'
    Plug 'vim-autoformat/vim-autoformat'
    " completion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
    Plug 'hrsh7th/cmp-omni'
    Plug 'hrsh7th/cmp-cmdline'
    " other
    Plug 'dstein64/vim-startuptime'
    Plug 'mhinz/vim-startify'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'svermeulen/vim-subversive'
    Plug 'luukvbaal/nnn.nvim'
    Plug 'poliquin/stata-vim'
    
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> SETTINGS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber
set mouse=a
set scrolloff=4                               " leaves space when scrolling
set nohlsearch
set incsearch                                 " search as characters are entered
set tabstop=4                                 " sets tab spacing
set shiftwidth=4                              " sets tab spacing
set expandtab                                 " sets tab spacing
set autoindent
set ignorecase                                " case-insensitive search
set smartcase                                 " case-insensitive search
set conceallevel=2                            " for markdown syntax
set iskeyword+=-                              " dash becomes part of word
set linebreak                                 " doesnt split words
set termguicolors
set breakindent                               " enable indentation
set breakindentopt=shift:2,min:40,sbr,list:-1 " ident by an additional 2 characters on wrapped lines,
                                              " when line >= 40 characters, put 'showbreak' at start of line
set showbreak=>>                              " append '>>' to indent
set noswapfile
set completeopt=menu,menuone,noselect
set nocursorline
" set cursorline                                " cursorline
" hi CursorLine term=bold guibg=gray25

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> OTHER SETTINGS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" removes cursorline when in insert mode
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" sets width when using 'gq'
au BufRead,BufNewFile *.tex setlocal textwidth=100
au BufRead,BufNewFile *.tex setlocal formatoptions-=t

" highlights text on yank
autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=700 }

" run python code
autocmd FileType python map <buffer> <leader>pp :w<CR>:ter python3 %<CR>

" restart kitty when saving conf file
autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep -a kitty)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> LUA <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('plugin-config/treesitter')
lua require('plugin-config/nvim-tree')
lua require('plugin-config/colorizer')
lua require('plugin-config/dracula-nvim')
lua require('plugin-config/nvim-cmp')
lua require('plugin-config/tokyonight')
lua require('plugin-config/catppuccin')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> COLORSCHEME <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme tokyonight-night
" colorscheme dracula
" colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

" makes neovim/nvimtree transparent
augroup user_colors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight NvimTreeNormal ctermbg=NONE guibg=NONE
  " autocmd ColorScheme * highlight LineNr guibg=none ctermbg=none
  " autocmd ColorScheme * highlight Folded guibg=none ctermbg=none
  " autocmd ColorScheme * highlight SpecialKey guibg=none ctermbg=none
  " autocmd ColorScheme * highlight VertSplit guibg=none ctermbg=none
  " autocmd ColorScheme * highlight SignColumn guibg=none ctermbg=none
  " autocmd ColorScheme * highlight EndOfBuffer guibg=none ctermbg=none
  " autocmd ColorScheme * highlight StatusLine   guibg=NONE ctermbg=NONE
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> KEYBINDING <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" move between panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" move between buffers
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <Leader>qq :bdelete!<CR>
nnoremap <Leader>qa :%bd\|e#<CR>:bnext<CR>:bd<CR>

" move line/down
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>

" copy to clipboard
noremap <Leader>y "*y

" no register for x
nnoremap x "_x

" leave insert mode
inoremap jk <esc>

" quit all
nnoremap <Leader>zz :qa!<CR>

" file path
nnoremap <leader>fp :let @*=expand("%:p")<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" faster in/outdenting
inoremap << <c-d>
inoremap >> <c-t>

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> VIMRC <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" type :Config to enter this init.vim
command! Config execute ":e $MYVIMRC"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> PLUGINS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""
" ale
""""""""""""""
let g:ale_linters = {'python': ['flake8', 'pyflakes'], 'r': ['lintr']}
let g:ale_fixers = {'python': ['black'], 'r': ['styler']}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_disable_lsp = 0


""""""""""""""
" autopairs
""""""""""""""
let g:AutoPairsShortcutFastWrap = '<c-e>'
let g:AutoPairsShortcutJump = '<c-n>'



""""""""""""""
" floaterm
""""""""""""""
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_keymap_toggle = '<F12>'


""""""""""""""
" FZF
""""""""""""""
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --margin=1,4"
nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fg <cmd>Rg<cr>
nnoremap <leader>fc <cmd>History:<cr>
nnoremap <leader>fb <cmd>BLines<cr>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files --no-ignore-vcs')
"!{node_modules/*,.git/*}"
" -g "!{*,.csv}"
command! -bang -nargs=* Rg
      \   call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --glob "!*.{csv,txt}" --color=always -g "*.{md,R,do,py,lua,vim}" --smart-case -- '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)


""""""""""""""
" jupyter
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
    au BufRead,BufNewFile *.do JupyterConnect
    " cycle through completion with tab
    " au FileType python inoremap <silent><expr> <Tab>
augroup END

""""""""""""""
" nvim-r
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
" nvim-tree
""""""""""""""
nnoremap <silent> <leader>v :NvimTreeToggle<cr>


""""""""""""""
" ulti-snips
""""""""""""""
let g:UltiSnipsExpandTrigger=";;"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']


""""""""""""""
" vim-airline
""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='molokai'
let g:airline_section_c='%F'
let g:airline_section_z='line:%l/%L col:%c'
let g:airline_section_y=airline#section#create_right(['%{strftime("%Y/%m/%d %H:%M:%S")}'])
let g:airline_section_b = '%t'


""""""""""""""
" vim-autoformat
""""""""""""""
" let g:python3_host_prog="/opt/homebrew/Cellar/python@3.10/3.10.6_2/bin/python3"
let g:python3_host_prog="/opt/homebrew/bin/python3"
let g:formatdef_latexindent = '"latexindent -"'


""""""""""""""
" vim-markdown
""""""""""""""
" hi htmlH1 guifg=#FFFF00 gui=bold,underline
" hi Comment guifg=#737aa2
let g:markdown_fenced_languages = ['python=python', 'r=r']
let g:vim_markdown_autowrite = 1            " auto-saves when entering link
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1          " highlights yaml frontmatter
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_new_list_item_indent = 0 " no indent when pressing typing 'o'
" let g:vim_markdown_folding_style_pythonic = 1 " folding style
" au FileType vimwiki setlocal foldlevel=5


""""""""""""""
" vim-markdown
""""""""""""""
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'



""""""""""""""
" vim-subversive
""""""""""""""
" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)



""""""""""""""
" vimtex
""""""""""""""
let g:vimtex_quickfix_mode=0


""""""""""""""
" vimwiki
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
let g:vimwiki_tag_format = {'pre': '\(^[ -]*tags\s*:.*\)\@<=', 'pre_mark': '', 'post_mark': '', 'sep': '>><<'}
"autocmd BufNewFile */wiki/diary/[0-9]*.md :read ~/Documents/wiki/template_diary.tpl


""""""""""""""
" vim-zettel
""""""""""""""
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
let g:zettel_format = '%Y%m%d%H%M%S'
let g:zettel_options = [{"disable_front_matter": 1, "template" :  "~/Documents/wiki/template.tpl"}]
let g:vimwiki_markdown_link_ext = 1


""""""""""""""
" vimwiki-sync
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





" shows the highlight group under cursor, e.g. htmlH1
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <leader>gm :call SynStack()<CR>
