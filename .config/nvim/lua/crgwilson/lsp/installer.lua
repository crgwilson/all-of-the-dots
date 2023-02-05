local mason_ok, mason = pcall(require, "mason")
local mason_lsp_config_ok, mason_lsp_config = pcall(require, "mason-lspconfig")

if not mason_ok or not mason_lsp_config_ok then
  return
end

mason.setup()

local M = {}

function M.ensure_installed(lsp_servers)
  mason_lsp_config.setup({
    ensure_installed = lsp_servers,
  })
end

return M
