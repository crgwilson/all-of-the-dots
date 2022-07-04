vim.opt.termguicolors = true

vim.cmd("let g:jellybeans_overrides = {'background': { 'ctermbg': 'none', '256ctermbg': 'none', 'guibg': 'none'}}")

-- tried pcalling vim.cmd here, but that spits out more error messages than I'd like
vim.cmd [[
try
  colorscheme jellybeans
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  echo 'Could not find intended colorscheme, it may not be installed'
  set background=dark
endtry
]]
