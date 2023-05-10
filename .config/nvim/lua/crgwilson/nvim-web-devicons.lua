local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
if not devicons_ok then
  vim.notify("Could not load nvim-web-devicons")
  return
end

devicons.setup()
