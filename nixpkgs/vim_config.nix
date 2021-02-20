custom_config = ''
set clipboard=unnamedplus
autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType r setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType rmd setlocal expandtab shiftwidth=2 softtabstop=2
set relativenumber
set number
set backspace=indent,eol,start
set mouse=
set history=500
filetype plugin on
filetype indent on
set autoread
let mapleader = ","
nmap <leader>w :w!<cr>
set so=7
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set foldcolumn=1
syntax enable
set encoding=utf8
set nobackup
set nowb
set noswapfile
map <space> /
map <c-space> ?
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
map 0 ^
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
    vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
    inoremap $4 {<esc>o}<esc>O
    iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
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
  let g:vimtex_view_method = 'zathura'
  autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_conceal_code_blocks = 0
  nmap <leader>kk <Plug>RMakeAll
  let g:pymode_lint_on_write = 0
  let g:slime_target = "vimterminal"
  let g:slime_vimterminal_cmd = "ipython"
  let g:slime_python_ipython = 1
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.[R]md set filetype=markdown.pandoc
augroup END
let R_assign = 3
""let g:github_colors_soft = 1
colorscheme github
let g:lightline = {'colorscheme' : 'github'}
''
