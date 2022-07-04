local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
 return
end

configs.setup({
  ensure_installed = "all",  -- pls no break
  ignore_install = { "" },

  highlight = {
    enable = true,
    disable = { "" },
  }
})
