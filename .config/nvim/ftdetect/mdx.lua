local mdx_augroup = vim.api.nvim_create_augroup("mdx_augroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.mdx" },
    command = "setlocal ft=markdown nobackup noswapfile",
    group = mdx_augroup,
})
