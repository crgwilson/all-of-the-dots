local lspinstaller = require("crgwilson.lsp.installer")
local dap_python_ok, dap_python = pcall(require, "dap-python")

vim.cmd([[
  function! Pytest()
    !pytest %
  endfunction

  :command! Pytest :call Pytest()
]])

vim.api.nvim_set_keymap(
  "n",
  "<leader>T",
  ":Pytest",
  { noremap = true, silent = true }
)

if not dap_python_ok then
  return
end

local debugpy_dir = lspinstaller.get_install_path("debugpy")
dap_python.setup(debugpy_dir .. "/venv/bin/python")
dap_python.test_runner = "pytest"

vim.api.nvim_set_keymap(
  "n",
  "<leader>bt",
  "<cmd>lua require'dap-python'.test_class()<cr>",
  { noremap = true}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>bm",
  "<cmd>lua require'dap-python'.test_method()<cr>",
  { noremap = true}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>bs",
  "<cmd>lua require'dap-python'.debug_selection()<cr>",
  { noremap = true}
)
