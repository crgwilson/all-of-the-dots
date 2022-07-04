local g = vim.g

g.Illuminate_ftblacklist = { [[nerdtree]], [[md]] }
vim.cmd([[
  augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=bold,underline gui=bold,underline
  augroup END
]])
