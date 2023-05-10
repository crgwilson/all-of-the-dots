local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local lsphandler_ok, lsphandler = pcall(require, "crgwilson.lsp.handler")
local lspinstaller_ok, lspinstaller = pcall(require, "crgwilson.lsp.installer")
local null_ls_ok, null_ls = pcall(require, "crgwilson.lsp.null-ls")

if not lspconfig_ok or not lspinstaller_ok or not lsphandler_ok then
  return
end

local servers = {
  -- "ansiblels",
  "bashls",
  "dockerls",
  "ember",
  "eslint",
  -- "gopls",
  "gradle_ls",
  "html",
  "jsonls",
  "pyright",
  "lua_ls",
  "terraformls",
  "tsserver",
  "vimls",
  -- "yamlls",
}

lspinstaller.ensure_installed(servers)

for _, server in pairs(servers) do
  local options = lsphandler.get_default_options()

  local found_custom_options, server_custom_options = pcall(require, "crgwilson.lsp.lsp-servers." .. server)
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

-- Uncomment this for debug logging
-- vim.lsp.set_log_level("debug")
vim.diagnostic.config(lsp_config)

null_ls.setup()
