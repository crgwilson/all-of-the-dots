" illuminate settings
let g:Illuminate_ftblacklist = ['nerdtree', 'md']
augroup illuminate_augroup
  autocmd!
  autocmd VimEnter * hi illuminatedWord cterm=bold,underline gui=bold,underline
augroup END
