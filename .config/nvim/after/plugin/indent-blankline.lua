local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
  vim.notify("Could not load indent-blankline", 2)
  return
end

indent_blankline.setup {
  show_end_of_line = true,
  space_char_blankline = " ",
}
