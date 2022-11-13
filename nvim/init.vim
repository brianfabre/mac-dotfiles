let mapleader=" "

call plug#begin('~/.local/share/nvim/plugged')

        " colorscheme
        Plug 'Mofiqul/dracula.nvim'
        Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
        " snippets
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'
        " fzf
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        " nvim-tree
        Plug 'kyazdani42/nvim-tree.lua'
        Plug 'kyazdani42/nvim-web-devicons'
        " markdown
        Plug 'preservim/vim-markdown'
        Plug 'godlygeek/tabular'
        " vim-airline
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        " vim-wiki
        Plug 'vimwiki/vimwiki'
        Plug 'michal-h21/vim-zettel'
        Plug 'michal-h21/vimwiki-sync'
        Plug 'mattn/calendar-vim'
        " latex
        Plug 'lervag/vimtex'
        Plug 'vim-autoformat/vim-autoformat'
        Plug 'Yggdroot/indentLine'
        " other
        Plug 'dstein64/vim-startuptime'
        Plug 'ggandor/leap.nvim'
        Plug 'mhinz/vim-startify'
        Plug 'norcalli/nvim-colorizer.lua'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> SETTINGS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber
set mouse=a
set scrolloff=4           " leaves space when scrolling
set nohlsearch
set incsearch             " search as characters are entered
set tabstop=4             " sets tab spacing
set shiftwidth=4          " sets tab spacing
set expandtab             " sets tab spacing
set ignorecase            " case-insensitive search
set smartcase             " case-insensitive search
set conceallevel=2        " for markdown syntax
set iskeyword+=-          " dash becomes part of word
set linebreak             " doesnt split words
set termguicolors
set cursorline            " cursorline
hi CursorLine term=bold guibg=gray25

" enable indentation
set breakindent
" ident by an additional 2 characters on wrapped lines, when line >= 40 characters, put 'showbreak' at start of line
set breakindentopt=shift:2,min:40,sbr,list:-1
" append '>>' to indent
set showbreak=>>


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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> LUA <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('plugin-config/nvim-tree')
lua require('plugin-config/treesitter')
lua require('plugin-config/colorizer')
lua require('plugin-config/dracula-nvim')
lua require('leap').add_default_mappings()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> COLORSCHEME <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme dracula
"colorscheme tokyonight-night


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
inoremap kj <esc>

" quit all
nnoremap <Leader>zz :qa!<CR>

" file path
nnoremap <leader>fp :let @*=expand("%:p")<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> VIMRC <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" type :Config to enter this init.vim
command! Config execute ":e $MYVIMRC"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ==> PLUGINS <==
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --margin=1,4"
nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fg <cmd>Rg<cr>
nnoremap <leader>fc <cmd>History:<cr>
nnoremap <leader>fb <cmd>BLines<cr>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files --no-ignore-vcs')


" nvim-tree
nnoremap <silent> <leader>v :NvimTreeToggle<cr>


" ulti-snips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='molokai'
let g:airline_section_c='%F'
let g:airline_section_z='line:%l/%L col:%c'
let g:airline_section_y=airline#section#create_right(['%{strftime("%Y/%m/%d %H:%M:%S")}'])
let g:airline_section_b = '%t'


" vim-autoformat
let g:python3_host_prog="/opt/homebrew/Cellar/python@3.10/3.10.6_2/bin/python3"
let g:formatdef_latexindent = '"latexindent -"'


" vim-markdown
"hi htmlH1 guifg=#FFFF00 gui=bold,underline
let g:markdown_fenced_languages = ['python', 'r']
let g:vim_markdown_autowrite = 1                  " auto-saves when entering link
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_new_list_item_indent = 0       " no indent when pressing typing 'o'
let g:vim_markdown_folding_style_pythonic = 1     " folding style
au FileType vimwiki setlocal foldlevel=5


" vimtex
let g:vimtex_quickfix_mode=0


" vimwiki
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
            \'diary_header': 'Journal'}]
augroup filetypedetect
    au BufEnter,BufNewFile,BufRead *.md			        setlocal syntax=markdown
"	 au BufEnter,BufNewFile,BufRead ~/Documents/wiki/*	setlocal syntax=markdown
"    au BufEnter,BufNewFile,BufRead *.tex			    setlocal syntax=latex
augroup END
let g:vimwiki_tag_format = {'pre': '\(^[ -]*tags\s*:.*\)\@<=', 'pre_mark': '', 'post_mark': '', 'sep': '>><<'}


" vim-zettel
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
let g:zettel_format = '%Y%m%d%H%M%S'
let g:zettel_options = [{"disable_front_matter": 1, "template" :  "~/Documents/wiki/template.tpl"}]
let g:vimwiki_markdown_link_ext = 1


" vim-sync
let g:vimwiki_list = [{
        \ 'path':'$HOME/Documents/wiki',
        \ 'syntax': 'markdown',
        \ 'ext': '.md'
\}]
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




let g:indentLine_fileType = ['tex']
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

