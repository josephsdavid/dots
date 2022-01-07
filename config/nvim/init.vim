lua <<EOF
require "user.options"
require "user.plugins"
require "user.lsp"
require "user.colorscheme"
require "user.treesitter"
require "user.keybinds"
require "user.cmp"
require "user.telescope"
require "user.toggleterm"
require "user.comment"
require "user.lualine"
EOF


augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * if argc() == 0 | Explore! | endif
augroup END

autocmd BufEnter * if expand("%:p:h") !~ '*.norg' | silent! lcd %:p:h | endif

set background=dark
set termguicolors
let g:hiPairs_enable_matchParen = 0
let g:hiPairs_hl_matchPair = { 'term'    : 'underline,bold',
            \                  'cterm'   : 'underline,bold',
            \                  'ctermfg' : '0',
            \                  'ctermbg' : '180',
            \                  'gui'     : 'underline,bold,italic',
            \                  'guifg'   : '#fb94ff',
            \                  'guibg'   : 'NONE' }


autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType r setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType rmd setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType lua setlocal expandtab shiftwidth=2 softtabstop=2

" Run currently focused python script with F9
autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType markdown nnoremap <buffer> <F9> :exec '!md2pdf' shellescape(@%, 1)<cr>
autocmd FileType yaml nnoremap <buffer> <F8> :exec '!cfn-lint' shellescape(@%, 1)<cr>
" format code with f8
autocmd FileType python nnoremap <buffer> <F8> :exec '!yapf -i' shellescape(@%, 1)<cr>
autocmd FileType rust nnoremap <buffer> <F8> :exec '!cargo fmt'<cr>
autocmd FileType sh nnoremap <buffer> <F8> :exec '!shfmt -w' shellescape(@%, 1)<cr>
autocmd FileType nix nnoremap <buffer> <F8> :exec '!nixfmt' shellescape(@%, 1)<cr>


filetype plugin on
filetype indent on
syntax enable
set so=7

hi Search cterm=underline,italic,bold ctermfg=250 ctermbg=NONE
"hi Visual ctermfg=NONE ctermbg=253
hi Visual ctermfg=250 ctermbg=NONE cterm=italic,bold,underline
highlight CocFloating ctermbg=255
highlight PmenuSel ctermbg=232  ctermfg=250 cterm=italic,bold
highlight Pmenu ctermbg=lightgray  ctermfg=black
highlight SignColumn ctermbg=0



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


runtime zepl/contrib/python.vim  " Enable the Python contrib module.
runtime zepl/contrib/nvim_autoscroll_hack.vim

let g:repl_config = {
            \   'python': {
            \     'cmd': 'python',
            \     'formatter': function('zepl#contrib#python#formatter')
            \   }
            \ }
tnoremap <Esc> <C-\><C-n>
runtime zepl/contrib/nvim_autoscroll_hack.vim

" pdb on leader b
map <leader>b :call InsertLine()<CR>

function! InsertLine()
  let trace = expand("import pdb; pdb.set_trace() #XXX: Breakpoint")
  execute "normal O".trace 
endfunction

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


nnoremap <silent> _ <C-^>
nmap <buffer> L <CR>:Lexplore<CR>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 25
let g:netrw_altv = 1
let g:netrw_winsize = 25

let g:zepl_default_maps = 0
nmap <silent> <Leader>s <Plug>ReplSend_Motion
vmap <silent> <Leader>s <Plug>ReplSend_Visual
nmap <silent> <Leader>ss :ReplSend <cr>
nmap <silent> <C-c> <Plug>ReplSend_Motion
vmap <silent> <C-c> <Plug>ReplSend_Visual
nmap <silent> <C-c>c :ReplSend <cr>
nmap <silent> <C-c><C-c> :ReplSend <cr>
let g:toggleterm_terminal_mapping = '<C-t>'


nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nmap <leader>w :w!<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext<cr>
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
