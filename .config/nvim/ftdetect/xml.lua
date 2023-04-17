local xml_augroup = vim.api.nvim_create_augroup("xml_augroup", { clear = true })
vim.api.nvim_create_autocmd(
  {"BufRead", "BufNewFile"}, {
    pattern = {"*.xml", "*.cfg", "*.src"},
    command = "set ft=xml",
    group = xml_augroup
  }
)
