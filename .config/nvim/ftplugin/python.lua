vim.cmd([[
  function! Pytest()
    !pytest %
  endfunction

  :command! Pytest :call Pytest()
]])

vim.api.nvim_set_keymap(
  "n",
  "<leader>t",
  ":Pytest",
  { noremap = true, silent = true }
)
