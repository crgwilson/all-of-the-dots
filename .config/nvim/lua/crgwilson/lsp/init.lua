require("crgwilson.lsp.cmp")
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local lsphandler_ok, lsphandler = pcall(require, "crgwilson.lsp.handler")
local lspinstaller_ok, lspinstaller = pcall(require, "crgwilson.lsp.installer")
local null_ls = require("crgwilson.lsp.null-ls")

if not lspconfig_ok or not lspinstaller_ok or not lsphandler_ok then
    return
end

local servers = {
    "bashls",
    "dockerls",
    "ember",
    "eslint",
    "gopls",
    "gradle_ls",
    "html",
    "jsonls",
    "lua_ls",
    -- "puppet",
    "pyright",
    "solargraph",
    "terraformls",
    "tsserver",
    "vimls",
}

-- mason-nvim-dap.nvim for some reason gives each debug adapter a unique
-- name which is _different_ than the name of the mason package, and if you
-- try to ensure_installed() the mason package name it will silently fail :)
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
local debug_adapters = {
    "python",
    "js",
    "delve",
}

lspinstaller.setup()
lspinstaller.install_lsp_servers(servers)
lspinstaller.install_debuggers(debug_adapters)

for _, server in pairs(servers) do
    local options = lsphandler.get_default_options()

    local found_custom_options, server_custom_options =
        pcall(require, "crgwilson.lsp.lsp-servers." .. server)
    if found_custom_options then
        options = vim.tbl_deep_extend("force", options, server_custom_options)
    end

    lspconfig[server].setup(options)
end

local lsp_config = {
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
}

-- vim.lsp.set_log_level("debug")
vim.diagnostic.config(lsp_config)
null_ls.setup()

require("crgwilson.lsp.dap")
