vim.cmd([[
  function! Pytest()
    !pytest %
  endfunction

  :command! Pytest :call Pytest()
]])

vim.api.nvim_set_keymap(
  "n",
  "<leader>T",
  ":Pytest",
  { noremap = true, silent = true }
)
