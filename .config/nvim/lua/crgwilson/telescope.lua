local ok, telescope = pcall(require, "telescope")

telescope.setup({
  defaults = {
    prompt_prefix = ">",
    color_devicons = true,
  }
})
