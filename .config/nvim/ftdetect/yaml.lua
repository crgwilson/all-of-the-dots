local yaml_augroup =
    vim.api.nvim_create_augroup("yaml_augroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.yaml", "*.yml", "*.ingraphs" },
    command = "set ft=yaml",
    group = yaml_augroup,
})
