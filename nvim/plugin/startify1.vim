let g:startify_lists = [
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'files',     'header': ['   Files']            },
          \ ]

let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.lua' },
            \ { 'w': '~/Documents/wiki/index.md' },
            \ { 'a': '~/Documents/R' },
            \ { 's': '~/Documents/PycharmProjects' },
            \ { 'd': '~/Documents/Latex' },
            \ { 'f': '~/Documents/Stata' },
            \ ]

let g:startify_padding_left = 10

let g:ascii = [
        \'███    ██ ███████  ██████  ██    ██ ██ ███    ███ ',
        \'████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ',
        \'██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ',
        \'██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ',
        \'██   ████ ███████  ██████    ████   ██ ██      ██ ',
        \]

let g:startify_custom_header =
      \ 'startify#center(g:ascii)'

let g:startify_skiplist = [
	            \ 'Documents/wiki/.*',
	            \ '.config/nvim/init.vim',
	            \ ]

" let g:startify_custom_indices = ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l']
