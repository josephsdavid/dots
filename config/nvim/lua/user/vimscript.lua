-- autocmd! remove all autocommands, if entered under a group it will clear that group
vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

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
  

]]

