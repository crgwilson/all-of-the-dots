local lspinstaller_ok, lspinstaller = pcall(require, "nvim-lsp-installer")

if not lspinstaller_ok then
  return
end

local M = {}

function M.ensure_installed(lsp_servers)
  lspinstaller.setup({
    ensure_installed = lsp_servers,
  })
end

return M
