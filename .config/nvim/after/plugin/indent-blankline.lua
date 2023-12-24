local ok, indent_blankline = pcall(require, "ibl")
if not ok then
  vim.notify("Could not load indent-blankline", 2)
  return
end

indent_blankline.setup {
  scope = {
    enabled = false,
  }
}
