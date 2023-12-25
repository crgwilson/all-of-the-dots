local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
    vim.notify("Could not load treesitter", 2)
    return
end

configs.setup({
    ensure_installed = "all", -- pls no break
    ignore_install = { "" },

    highlight = {
        enable = true,
        disable = { "" },
    },
})
