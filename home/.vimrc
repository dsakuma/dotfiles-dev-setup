" Enable plugins
call plug#begin()
Plug 'joshdick/onedark.vim', { 'as': 'onedark' }
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
call plug#end()

" Set color theme
set termguicolors
silent! colorscheme onedark

" Highlight syntax
syntax on

" Enable wildmenu
set wildmenu

" Allow backspace over indent, eol and start
:set backspace=2

" Highlight matching in search
set hlsearch

" Disable swapfiles
set noswapfile

" Do not wrap lines
set nowrap

" Permit to change buffer without saving
set hidden

" Set encoding
set encoding=utf-8
set fileencodings=utf-8

" Open new split panes to right and bottom
set splitbelow
set splitright

" Tabs and spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

