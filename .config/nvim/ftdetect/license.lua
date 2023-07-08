local license_augroup = vim.api.nvim_create_augroup("license_augroup", { clear = true })
vim.api.nvim_create_autocmd(
  {"BufRead", "BufNewFile"}, {
    pattern = {"license", "LICENSE"},
    command = "setlocal ft=license",
    group = license_augroup
  }
)
