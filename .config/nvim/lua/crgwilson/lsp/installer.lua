local mason_ok, mason = pcall(require, "mason")
local mason_lsp_config_ok, mason_lsp_config = pcall(require, "mason-lspconfig")
local mason_dap_ok, mason_dap = pcall(require, "mason-nvim-dap")
local mason_registry_ok, mason_registry = pcall(require, "mason-registry")

if not mason_ok or
  not mason_lsp_config_ok or
  not mason_registry_ok or
  not mason_dap_ok then
  return
end

local M = {}

function M.setup()
  mason.setup()
end

function M.install_lsp_servers(lsp_servers)
  mason_lsp_config.setup({
    ensure_installed = lsp_servers,
  })
end

function M.install_debuggers(debuggers)
  mason.setup()
  mason_dap.setup({
    ensure_installed = debuggers,
    automatic_installation = true,
  })
end

function M.get_install_path(package_name)
  return mason_registry.get_package(package_name):get_install_path()
end

return M
