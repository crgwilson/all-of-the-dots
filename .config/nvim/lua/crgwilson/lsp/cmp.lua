local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")

if not cmp_ok then
  vim.notify("Could not load cmp, lsp will be broken", 2)
  return
end

if not luasnip_ok then
  vim.notify("Could not load luasnip, snippets will be broken", 2)
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = {
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<Left>"] = cmp.mapping(cmp.mapping.scroll_docs(-1)),
    ["<Right>"] = cmp.mapping(cmp.mapping.scroll_docs(1)),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete()),
    ["<CR>"] = function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm()
      else
        fallback()
      end
    end
  },
  window = {
    documentation = {
      max_height = 15,
      max_width = 60,
    }
  },
  formatting = {
    fields = { "abbr", "menu", "kind" },
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end
  },
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  view = {
    entries = "custom",
  },
  preselect = cmp.PreselectMode.None,
})
