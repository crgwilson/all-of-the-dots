" Installing everything only when I need to
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Muh plugins
call plug#begin('~/.config/nvim/plugged')

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
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'w0rp/ale'

call plug#end()

" vim-airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'

" ansible-vim settings
let g:ansible_unindent_after_newline=1
let g:ansible_attribute_highlight='ob'

" deoplete settings
let g:deoplete#enable_at_startup = 1
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
let g:ale_lint_delay = 2000
" having both better-whitespace and ale complain about trailing whitespace is
" a bit much...
let b:ale_warn_about_trailing_whitespace = 0
" specify specific linters to load here
" linters available: https://github.com/w0rp/ale#supported-languages
let g:ale_linters = {
\  'python': ['flake8'],
\}

" vim settings
syntax on
set number
set shiftwidth=2
set tabstop=2
set expandtab

" spell check in markdown
augroup markdownSpell
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md setlocal spell
augroup END
