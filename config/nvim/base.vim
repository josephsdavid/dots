set bg=light

"use system clipboard
set clipboard=unnamedplus

set expandtab

" tab width stuff
autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType r setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType rmd setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2

" Run currently focused python script with F9
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType markdown nnoremap <buffer> <F9> :exec '!md2pdf' shellescape(@%, 1)<cr>
" format code with f8
autocmd FileType python nnoremap <buffer> <F8> :exec '!black' shellescape(@%, 1)<cr>
autocmd FileType sh nnoremap <buffer> <F8> :exec '!shfmt -w' shellescape(@%, 1)<cr>
autocmd FileType nix nnoremap <buffer> <F8> :exec '!nixfmt' shellescape(@%, 1)<cr>

" other autocmds
autocmd FileType markdown setlocal spell
" relative numbering on the number line for conveneient jumping
"set relativenumber
set number

" backspace stuff
set backspace=indent,eol,start

" mouse is for babies
set mouse=

" vim command line history
set history=500

" plugins and filetype stuff
filetype plugin on
filetype indent on
syntax enable

" read files that have been changed outside of vim
set autoread

" cant remember what this does
set so=7

" searching stuff
set ignorecase
set smartcase
set hlsearch


hi Search cterm=underline,italic,bold ctermfg=250 ctermbg=NONE
"hi Visual ctermfg=NONE ctermbg=253
hi Visual ctermfg=250 ctermbg=NONE cterm=italic,bold,underline
highlight PmenuSel ctermbg=232  ctermfg=250 cterm=italic,bold
highlight Pmenu ctermbg=darkgray  ctermfg=black
highlight cocFloating ctermbg=black
set incsearch
" magic searches
set magic
set completeopt=longest,menuone

" makes vim a little faster when replaying macros
set lazyredraw

" folding
set foldcolumn=1
set encoding=utf8

" undo, backup, swap directories for when I accidentally hit ZZ
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set noswapfile



" Status bar things
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c



fun! CleanExtraSpaces()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	silent! %s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfun
if has("autocmd")
	autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" more status bar stuff
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>



let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" stuff for R and Rmarkdown
"augroup pandoc_syntax
"	au! BufNewFile,BufFilePre,BufRead *.[R]md set filetype=markdown.pandoc
"augroup END
let R_assign = 3
