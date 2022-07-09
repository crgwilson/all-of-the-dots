local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local lspinstaller_ok, lspinstaller = pcall(require, "nvim-lsp-installer")
local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")

if not lspconfig_ok or not lspinstaller_ok or not cmp_ok then
  return
end

local api = vim.api

local servers = {
  -- "ansiblels",
  "bashls",
  "dockerls",
  "ember",
  "eslint",
  -- "gopls",
  "gradle_ls",
  "html",
  "jdtls",
  "jsonls",
  "pyright",
  "sumneko_lua",
  "terraformls",
  "tsserver",
  "vimls",
  "yamlls",
}

lspinstaller.setup({
  ensure_installed = servers,
})

function lsp_format()
  vim.lsp.buf.formatting{async = true}
  vim.notify("Formatted buffer", 1)
end

local function lsp_keymaps(bufnr)
  local options = {
    noremap = true,
    silent = true
  }
  api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
  api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", options)
  api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", options)
  api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", options)
  api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", options)
  api.nvim_buf_set_keymap(bufnr, "n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<cr>", options)
  api.nvim_buf_set_keymap(bufnr, "n", "<leader>F", "<cmd>lua lsp_format()<cr>", options)
  -- TODO: Organize imports!
end

local function on_attach(client, bufnr)
  lsp_keymaps(bufnr)
end

local capabilities = cmp.update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

for _, server in pairs(servers) do
  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  local found_custom_options, server_custom_options = pcall(require, "crgwilson.lspservers." .. server)
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

vim.diagnostic.config(lsp_config)

-- null-ls
local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- ansible
    -- diagnostics.ansiblelint,

    -- python
    diagnostics.flake8,
    diagnostics.mypy,
    formatting.black.with({ extra_args = { "--fast" } }),

    -- bash
    diagnostics.shellcheck,

    -- js / ts
    diagnostics.eslint,

    -- lua
    -- formatting.stylua,

    -- yaml
    diagnostics.yamllint,
  }
})
