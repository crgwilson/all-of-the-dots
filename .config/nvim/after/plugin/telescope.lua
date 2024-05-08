local ok, telescope = pcall(require, "telescope")
if not ok then
    vim.notify("Could not load telescope", 2)
    return
end

telescope.setup({
    defaults = {
        prompt_prefix = ">",
        disable_devicons = false,
        color_devicons = true,
        path_display = { truncate = 2 },
        file_ignore_patterns = {
            "node_modules",
            "venv",
        },
    },
})
