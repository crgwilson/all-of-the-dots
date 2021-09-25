" fzf settings
let g:fzf_nvim_statusline = 0
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" fuzzy find files with space
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fg :Rg<CR>
nnoremap <silent> <leader>fc :Commands<CR>
nnoremap <silent> <leader>fs :Snippets<CR>
