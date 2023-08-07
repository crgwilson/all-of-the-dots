local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {
        "NvimTree",
        "dapui_console",
        "dap-repl",
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
      },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      -- Stolen from https://github.com/nvim-lualine/lualine.nvim/issues/820
      function()
        local fn = vim.fn.expand('%:~:.')
        if vim.startswith(fn, "jdt://") then
          fn = string.sub(fn, 0, string.find(fn, "?") - 1)
        end
        if fn == '' then
          fn = '[No Name]'
        end
        if vim.bo.modified then
          fn = fn .. ' [+]'
        end
        if vim.bo.modifiable == false or vim.bo.readonly == true then
          fn = fn .. ' [-]'
        end
        local tfn = vim.fn.expand('%')
        if tfn ~= '' and vim.bo.buftype == '' and vim.fn.filereadable(tfn) == 0 then
          fn = fn .. ' [New]'
        end
        return fn
      end
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
