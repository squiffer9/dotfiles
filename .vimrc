" Basic Settings
set nocompatible
filetype plugin indent on
syntax on
set encoding=utf-8
set number
set relativenumber
set hidden
set ruler
set showcmd
set wildmenu
set wildmode=longest:full,full
set laststatus=2
set backspace=indent,eol,start
set clipboard=unnamed
set mouse=a

" Search Settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indentation
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent

" Appearance
set termguicolors
colorscheme desert
set cursorline

" File type specific settings
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab

" Plugins (using vim-plug)
call plug#begin('~/.vim/plugged')

" Go development
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File explorer
Plug 'scrooloose/nerdtree'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax highlighting for various languages
Plug 'sheerun/vim-polyglot'

" YAML support
Plug 'stephpy/vim-yaml'

" Markdown support
Plug 'plasticboy/vim-markdown'

" Docker support
Plug 'ekalinin/Dockerfile.vim'

" Terraform support
Plug 'hashivim/vim-terraform'

call plug#end()

" Plugin specific settings
" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>

" vim-go
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" coc.nvim
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Custom key mappings
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <space> za
vnoremap <space> za
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>

" Mermaid syntax highlighting
au BufRead,BufNewFile *.mmd set filetype=mermaid

" YAML specific settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Terraform specific settings
let g:terraform_fmt_on_save=1

" Markdown specific settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" Disable arrow keys to enforce hjkl usage
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>




