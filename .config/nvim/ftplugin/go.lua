vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

local lspinstaller = require("crgwilson.lsp.installer")
local dap_go_ok, dap_go = pcall(require, "dap-go")

if not dap_go_ok then
    return
end

local delve_dir = lspinstaller.get_install_path("delve")
dap_go.setup({
    delve = {
        path = delve_dir .. "/dlv",
    },
})

vim.api.nvim_set_keymap(
    "n",
    "<leader>bt",
    "<cmd> lua require'dap-go'.debug_test()<cr>",
    { noremap = true }
)
