function! Pytest()
  !pytest %
endfunction

:command! Pytest :call Pytest()
nnoremap <silent> <leader>t :Pytest<CR>
