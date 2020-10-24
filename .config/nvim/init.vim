" Installing everything only when I need to
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Muh plugins
call plug#begin('~/.config/nvim/plugged')

" For the looks
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" For general behavior
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-endwise'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'AndrewRadev/splitjoin.vim' " Adds gS and gJ to split / join lines
Plug 'chrisbra/NrrwRgn'
Plug 'tomtom/tcomment_vim'
Plug 'psliwka/vim-smoothie'
Plug 'rrethy/vim-illuminate'

" For sittin in trees (needs nvim nightly)
Plug 'nvim-treesitter/nvim-treesitter'

" For git integration
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" For fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language syntax
Plug 'vim-ruby/vim-ruby'
Plug 'fatih/vim-go'
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
Plug 'rodjek/vim-puppet'
Plug 'pearofducks/ansible-vim'
Plug 'https://github.com/m-kat/aws-vim'
Plug 'hashivim/vim-terraform'
Plug 'ap/vim-css-color'
Plug 'ekalinin/Dockerfile.vim'
Plug 'kergoth/vim-bitbake'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" jellybeans settings
colorscheme jellybeans
let g:jellybeans_use_term_background_color = 1

" vim-airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'

" Integrated terminal
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" vim settings
" let mapleader=","
syntax on
set number
set relativenumber

set shiftwidth=2
set tabstop=2
set expandtab
set softtabstop=2 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

set lazyredraw
set mouse=

set hidden
set ignorecase
set smartcase
set cursorline

set splitbelow
set splitright

" undo stuff
if !isdirectory($HOME . '/.config/nvim/undo')
  call mkdir($HOME . '/.config/nvim/undo', 'p')
endif
set undodir=~/.config/nvim/undo
set undofile
set undoreload=10000

" backup stuff
set nobackup
set nowritebackup

" navigate splits w/ ctrl + direction
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
