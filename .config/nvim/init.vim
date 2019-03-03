" Installing everything only when I need to
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Muh plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-endwise'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'vim-ruby/vim-ruby'
Plug 'fatih/vim-go'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rodjek/vim-puppet'
Plug 'pearofducks/ansible-vim'
Plug 'https://github.com/m-kat/aws-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'sebastianmarkow/deoplete-rust',
Plug 'w0rp/ale'
Plug 'hashivim/vim-terraform'
Plug 'scrooloose/nerdtree'
Plug 'AndrewRadev/splitjoin.vim' " Adds gS and gJ to split / join lines
Plug 'ap/vim-css-color'
Plug 'ekalinin/Dockerfile.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

" jellybeans settings
colorscheme jellybeans
let g:jellybeans_use_term_background_color = 1

" vim-airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'

" nerdtree settings
let g:NERDTreeMinimalUI = 1
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeWinSize = 31
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeCascadeOpenSingleChildDir = 1

map <F1> :call NERDTreeToggleAndFind()<cr>
map <F2> :NERDTreeToggle<CR>

function! NERDTreeToggleAndFind()
  if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
    execute ':NERDTreeClose'
  else
    execute ':NERDTreeFind'
  endif
endfunction

" fzf settings
let g:fzf_nvim_statusline = 0
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" fuzzy find files with space
nnoremap <silent> <space> :Files<CR>

" ansible-vim settings
let g:ansible_unindent_after_newline=1
let g:ansible_attribute_highlight='ob'

" deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#ignore_errors = 1
set completeopt-=preview

" deoplete jedi settings
" NOTE: The below lines must be pointed at existing pyenv virtual envs for
" python2 and python3 respectively, otherwise autocomplete won't work
let g:python_host_prog = '/Users/cwilson/.pyenv/versions/nvim2/bin/python'
let g:python3_host_prog = '/Users/cwilson/.pyenv/versions/nvim3/bin/python'

" deoplete-go settings
" NOTE: This one requires gocode installed
" Assuming your GOPATH is set just run `go get -u github.com/mdempsky/gocode`
let g:deoplete#sources#go#gocode_binary = '/Users/cwilson/go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" ale settings
let g:ale_lint_delay = 1000
" having both better-whitespace and ale complain about trailing whitespace is
" a bit much...
let b:ale_warn_about_trailing_whitespace = 0
" specify specific linters to load here
" linters available: https://github.com/w0rp/ale#supported-languages
let g:ale_linters = {
\  'python': ['flake8'],
\  'rust': ['rls'],
\}

" ultisnips settings
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = '~/.config/nvim/snippets'

" vim settings
syntax on
set number

set shiftwidth=2
set tabstop=2
set expandtab
set softtabstop=2 " remove <Tab> symbols as it was spaces
set shiftwidth=2  " indent size for << and >>
set shiftround

set lazyredraw
set mouse=""

set ignorecase
set smartcase
set cursorline

" navigate splits w/ ctrl + direction
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" groups
" spell check in markdown
augroup markdownSpell
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md setlocal spell
augroup END
