" fzf settings
let g:fzf_nvim_statusline = 0
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" fuzzy find files with space
nnoremap <silent> <space><space> :Files<CR>
