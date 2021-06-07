# NeoVim configuration

We will walk through my vim configuration here!!

# init.vim

First, we have the file that neovim calls on opening to configure, `~/.config/nvim/init.vim`. My vim config is modular, and in multiple files, but you could easily set it up to all be in init.vim. We will walk through line by line

## Plugins  

I use vim-plug to manage my plugins, you can install it by running:

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

```

To update the installed plugins, in vim, run `:PlugInstall`!

```vim
call plug#begin('~/.data/plugged') " directory where plugins are stored
Plug 'axvr/zepl.vim' " repl for vim
Plug 'tpope/vim-repeat' " better repeats with .
Plug 'tpope/vim-vinegar' " file explorer with `-`, go back with Ctrl-6
Plug 'tpope/vim-surround' " Manipulate braces and quotes
Plug 'jiangmiao/auto-pairs'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive' " Git plugin
Plug 'vim-pandoc/vim-pandoc-syntax' " fancy highlighting for markdown
Plug 'neoclide/coc.nvim' " The completion engine
Plug 'vimlab/split-term.vim' " More conveneint terminals in neovim (:Term and :VTerm)
Plug 'Yggdroot/indentLine' " show lines for indentation
call plug#end()

source ~/.config/nvim/base.vim
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/coc_config.vim
```

## COC settings

To get good completion for python, install nodejs and then run `:CocInstall coc-pyright`, to install the [pyright](https://github.com/fannheyward/coc-pyright) completion and linting engine

# base.vim

This is where general configuration goes!

```vim
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
" format code with f8
autocmd FileType python nnoremap <buffer> <F8> :exec '!black' shellescape(@%, 1)<cr>
autocmd FileType sh nnoremap <buffer> <F8> :exec '!shfmt -w' shellescape(@%, 1)<cr>

" other autocmds
" autocmd FileType markdown setlocal spell
" relative numbering on the number line for conveneient jumping
set relativenumber
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
" magic searches
set incsearch
set magic


" some changes to the color scheme, for searches and menus, as well as making python a little prettier
hi Search cterm=underline,italic,bold ctermfg=250 ctermbg=NONE
"hi Visual ctermfg=NONE ctermbg=253
hi Visual ctermfg=250 ctermbg=NONE cterm=italic,bold,underline
highlight PmenuSel ctermbg=232  ctermfg=250 cterm=italic,bold
highlight Pmenu ctermbg=lightgray  ctermfg=black
highlight cocFloating ctermbg=black
highlight SignColumn ctermbg=0
hi pythonStatement ctermfg=2
hi pythonbuiltin ctermfg=14

" better completions
set completeopt=longest,menuone

" makes vim a little faster when replaying macros
set lazyredraw

" folding
set foldcolumn=0
set encoding=utf8

" undo, backup, swap directories for when I accidentally hit ZZ
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set noswapfile



" Status bar things
set laststatus=2
" more status bar stuff
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c\ %=\ TIME:\ %{strftime('%c')}


" on save, clean up whitespace in python files!
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




" markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" repl things, more will be explained later
runtime zepl/contrib/python.vim  " Enable the Python contrib module.
let g:repl_config = {
            \   'python': {
            \     'cmd': 'python',
            \     'formatter': function('zepl#contrib#python#formatter')
            \   }
            \ }
" terminal bindings to easily escape the terminal window
tnoremap <Esc> <C-\><C-n>
runtime zepl/contrib/nvim_autoscroll_hack.vim
```

Most of this is purely aesthetic, however the repl/zepl stuff is important


# Mappings

This is where the majority of the useful keymappings live!!

```vim
" start commands with `,`
let mapleader = ","

" save with <,w>
nmap <leader>w :w!<cr> 
" new tab with <,tn>
map <leader>tn :tabnew<cr>
" focus current tab with <,to>
map <leader>to :tabonly<cr>
" close current tab with <,tc>
map <leader>tc :tabclose<cr>
" move a tab with <,tm>
map <leader>tm :tabmove
" save with cycle tabs with <,t,>
map <leader>t<leader> :tabnext<cr>
" go to previous tab with <,tl>
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" set pdb breakpoint with <,b>
map <leader>b :call InsertLine()<CR>
function! InsertLine()
  let trace = expand("import pdb; pdb.set_trace()")
  execute "normal O".trace 
  execute "normal o"
endfunction


" toggle sidebar file browser with <,nn>
let g:NetrwIsOpen=0
function! ToggleNetrw()
	if g:NetrwIsOpen
		let i = bufnr("$")
		while (i >= 1)
			if (getbufvar(i, "&filetype") == "netrw")
				silent exe "bwipeout " . i 
			endif
			let i-=1
		endwhile
		let g:NetrwIsOpen=0
	else
		let g:NetrwIsOpen=1
		silent Lexplore
	endif
endfunction
map <leader>nn :call ToggleNetrw()<cr>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" easy searching
" search with <space>
map <space> /
" reverse search with <Ctrl+space>
map <c-space> ?

" jump between buffers with <Ctrl-DIRECTION> and <ALT-DIRECTION>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <M-j> <C-W>j
map <M-k> <C-W>k
map <M-h> <C-W>h
map <M-l> <C-W>l

" go to start of line with zero
map 0 ^

" send code to repl with <,s>, following normal vim motions
"  for example, to send a block (paragraph) of code, <,sip> (send code in paragraph)
let g:zepl_default_maps = 0
nmap <silent> <Leader>s <Plug>ReplSend_Motion
vmap <silent> <Leader>s <Plug>ReplSend_Visual
" send a single line with <,ss>
nmap <silent> <Leader>ss :ReplSend <cr>

" jump out of repl with <alt-direction>
tnoremap <Esc> <C-\><C-n>
tnoremap <M-j> <C-\><C-n><C-W>j
tnoremap <M-k> <C-\><C-n><C-W>k
tnoremap <M-h> <C-\><C-n><C-W>h
tnoremap <M-l> <C-\><C-n><C-W>l
```

# Important notes


Things to try:

* Open up a file browser with `-`
* pop back to original window with `Ctrl-6`
* Play around with opening things in the file browser, Ctrl-6, and -
* Try the same  things with `,nn` (sidebar files)
* add parenthesis around something with `ysiw)`  (add surroundings in word)
* change the parenthesis to brackits with `cs)]` (change surroundings from ) to ] )
* Add double quotes around the brackets with `ysa]"` (add surroundigs around brackets)
* add single quotes within the brackets with `ysi]'` (add surroundings in brackets)
* undo it all!
* redo it with ctrl-R
* Open up a new file in a new tabe with `:tabe file.py`
* cycle tabs with `gt`, `,tl`, `,t,` and try out other tab commands
* open a split with  `:sp file2.py`
* open a vertical split with `:vsp file3.py`
* Navigate the splits with `CTRL+DIRECTION`
* Do the same thing using alt instead of ctrl
* Move the splits around with `CTRL-W SHIFT+direction`
* open a python file
* open the python repl with `:Repl`
* Run the whole file with `gg,sG`
* Run a chunk of code with `,sip`
* Send a function with `,saf`, `,sif`
* Send a class with `,sac`
* Send a class with `,sic`
* Run a line of code with `,ss`
* Highlight a line of code in visual mode, and send it to the repl with `,s`
* write some new code in the repl, and copy and paste it into your file!
* Open up a vertical terminal with `:VT`
* Run the whole file with `python file.py` in the vertical terminal
