"Plugin section
call plug#begin('~/.data/plugged')
Plug 'axvr/zepl.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'LnL7/vim-nix'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'neoclide/coc.nvim'
Plug 'vimlab/split-term.vim'
Plug 'Yggdroot/indentLine'
call plug#end()
" begin of base.vim

source ~/.config/nvim/base.vim
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/coc_config.vim

