let mapleader = ","

" some shortcuts with <,-w> to save and tab commands
nmap <leader>w :w!<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" pdb on leader b
map <leader>b :call InsertLine()<CR>

function! InsertLine()
  let trace = expand("import pdb; pdb.set_trace()")
  execute "normal O".trace 
  execute "normal o"
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
map <leader>nn :call ToggleNetrw()<cr>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" easy searching
map <space> /
map <c-space> ?

" jump between buffers with <C-DIRECTION>
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

let g:zepl_default_maps = 0
nmap <silent> <Leader>s <Plug>ReplSend_Motion
vmap <silent> <Leader>s <Plug>ReplSend_Visual
nmap <silent> <Leader>ss :ReplSend <cr>

tnoremap <Esc> <C-\><C-n>


tnoremap <M-j> <C-\><C-n><C-W>j
tnoremap <M-k> <C-\><C-n><C-W>k
tnoremap <M-h> <C-\><C-n><C-W>h
tnoremap <M-l> <C-\><C-n><C-W>l
