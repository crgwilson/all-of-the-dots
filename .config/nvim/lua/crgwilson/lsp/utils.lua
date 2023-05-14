local mason_registry = require("mason-registry")

local M = {}
function M.get_install_path(package)
  return mason_registry.get_package(package):get_install_path()
end

return M
