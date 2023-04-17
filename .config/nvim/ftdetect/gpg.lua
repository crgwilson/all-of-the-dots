local gpg_augroup = vim.api.nvim_create_augroup("gpg_augroup", { clear = true })
vim.api.nvim_create_autocmd(
  {"BufRead", "BufNewFile"}, {
    pattern = {"*.asc", "*.gpg", "*.pgp"},
    command = "setlocal ft=text nobackup noswapfile",
    group = gpg_augroup
  }
)
