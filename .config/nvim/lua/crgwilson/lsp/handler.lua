local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
    return
end

local api = vim.api

local capabilities =
    cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

function lsp_format()
    vim.lsp.buf.format({ async = true })
    vim.notify("Formatted buffer", 1)
end

local function set_lsp_keymaps(bufnr)
    local options = {
        noremap = true,
        silent = true,
    }
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gd",
        "<cmd>lua vim.lsp.buf.definition()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gr",
        "<cmd>lua vim.lsp.buf.references()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gD",
        "<cmd>lua vim.lsp.buf.declaration()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gi",
        "<cmd>lua vim.lsp.buf.implementation()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "K",
        "<cmd>lua vim.lsp.buf.hover()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>d",
        "<cmd>lua vim.diagnostic.open_float()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gK",
        "<cmd>lua vim.lsp.buf.signature_help()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>F",
        "<cmd>lua lsp_format()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>R",
        "<cmd>lua vim.lsp.buf.rename()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>ca",
        "<cmd>lua vim.lsp.buf.code_action()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>n",
        "<cmd>lua vim.diagnostic.goto_next()<cr>",
        options
    )
    api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>N",
        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        options
    )
end

local function on_attach(client, bufnr)
    set_lsp_keymaps(bufnr)
end

local M = {}

function M.get_default_options()
    return {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

return M
