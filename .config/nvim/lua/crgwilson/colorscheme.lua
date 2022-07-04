vim.opt.termguicolors = true

local colorscheme = "jellybeans"
local has_configs, colorscheme_configs = pcall(require, "crgwilson.colorschemes." .. colorscheme)
if has_configs then
  colorscheme_configs.setup()
end

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  vim.notify("Could not find colorscheme jellybeans", 2)
  vim.cmd("colorscheme default")
end
