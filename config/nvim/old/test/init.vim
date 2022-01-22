lua <<EOF
require "user.options"
require "user.plugins"
require "user.lsp"
require "user.colorscheme"
require "user.treesitter"
require "user.keybinds"
require "user.cmp"
require "user.luasnip"
require "user.telescope"
require "user.toggleterm"
require "user.comment"
require "user.lualine"
require "user.clickfree"
-- require "user.lightspeed"
require "user.null-ls"
-- require "user.gitsigns"
require "user.neogit"
require "user.vimscript"
vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF


" augroup ProjectDrawer
"     autocmd!
"     autocmd VimEnter * if argc() == 0 | Explore! | endif
" augroup END
"
" autocmd BufEnter * if expand("%:p:h") !~ '*.norg' | silent! lcd %:p:h | endif
"
" " set background=dark
" " set termguicolors
" let g:hiPairs_enable_matchParen = 0
" let g:hiPairs_hl_matchPair = { 'term'    : 'underline,bold',
"             \                  'cterm'   : 'underline,bold',
"             \                  'ctermfg' : '0',
"             \                  'ctermbg' : '180',
"             \                  'gui'     : 'underline,bold,italic',
"             \                  'guifg'   : '#fb94ff',
"             \                  'guibg'   : 'NONE' }
"
"
" autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
" autocmd FileType r setlocal expandtab shiftwidth=2 softtabstop=2
" autocmd FileType rmd setlocal expandtab shiftwidth=2 softtabstop=2
" autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
" autocmd FileType lua setlocal expandtab shiftwidth=2 softtabstop=2

" Run currently focused python script with F9
" autocmd FileType python nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
" autocmd FileType markdown nnoremap <buffer> <F9> :exec '!md2pdf' shellescape(@%, 1)<cr>
" format code with f8
" autocmd FileType yaml nnoremap <buffer> <F8> :exec '!cfn-lint' shellescape(@%, 1)<cr>
" autocmd FileType python nnoremap <buffer> <F8> :exec '!yapf -i' shellescape(@%, 1)<cr>
" autocmd FileType rust nnoremap <buffer> <F8> :exec '!cargo fmt'<cr>
" autocmd FileType sh nnoremap <buffer> <F8> :exec '!shfmt -w' shellescape(@%, 1)<cr>
" autocmd FileType nix nnoremap <buffer> <F8> :exec '!nixfmt' shellescape(@%, 1)<cr>
" autocmd FileType lua nnoremap <buffer> <F8> :exec '!stylua' shellescape(@%, 1)<cr>


" filetype plugin on
" filetype indent on
" syntax enable
" set so=7

" hi Search cterm=underline,italic,bold ctermfg=250 ctermbg=NONE
" "hi Visual ctermfg=NONE ctermbg=253
" hi Visual ctermfg=250 ctermbg=NONE cterm=italic,bold,underline
" highlight CocFloating ctermbg=255
" highlight PmenuSel ctermbg=232  ctermfg=250 cterm=italic,bold
" highlight Pmenu ctermbg=lightgray  ctermfg=black
" highlight SignColumn ctermbg=0



" fun! CleanExtraSpaces()
" 	let save_cursor = getpos(".")
" 	let old_query = getreg('/')
" 	silent! %s/\s\+$//e
" 	call setpos('.', save_cursor)
" 	call setreg('/', old_query)
" endfun
" if has("autocmd")
" 	autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.lua :call CleanExtraSpaces()
" endif
"
"
" runtime zepl/contrib/python.vim  " Enable the Python contrib module.
" runtime zepl/contrib/nvim_autoscroll_hack.vim
"
" let g:repl_config = {
"             \   'python': {
"             \     'cmd': 'python',
"             \     'formatter': function('zepl#contrib#python#formatter')
"             \   },
"             \   'lua': { 'cmd': 'lua' },
"             \ }
" " tnoremap <Esc> <C-\><C-n>
" runtime zepl/contrib/nvim_autoscroll_hack.vim

"pdb on leader b
" map <C-b> :call InsertLine()<CR>




" nnoremap <silent> _ <C-^>
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 25
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
"
" let g:zepl_default_maps = 0
" nmap <silent> <Leader>s <Plug>ReplSend_Motion
" vmap <silent> <Leader>s <Plug>ReplSend_Visual
" nmap <silent> <Leader>ss :ReplSend <cr>


" nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" nmap <leader>w :w!<cr>
" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove 
" map <leader>t<leader> :tabnext<cr>
" let g:lasttab = 1
" map <Leader>tl :exe 'tabn '.g:lasttab<CR>
" au TabLeave * let g:lasttab = tabpagenr()

" nnoremap <leader>d <cmd>lua require('goto-preview').goto_preview_definition()<CR>
" nnoremap <leader>i <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
" nnoremap <leader>x <cmd>lua require('goto-preview').close_all_win()<CR>
" " Only set if you have telescope installed
" nnoremap <leader>r <cmd>lua require('goto-preview').goto_preview_references()<CR>

" nmap <expr> f reg_recording() . reg_executing() == '' ? '<Plug>Lightspeed_f' : 'f'
" nmap <expr> F reg_recording() . reg_executing() == '' ? '<Plug>Lightspeed_F' : 'F'
" nmap <expr> t reg_recording() . reg_executing() == '' ? '<Plug>Lightspeed_t' : 't'
" nmap <expr> T reg_recording() . reg_executing() == '' ? '<Plug>Lightspeed_T' : 'T'