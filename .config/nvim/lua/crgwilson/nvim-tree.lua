local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  vim.notify("Could not load nvim-tree", 2)
end

nvim_tree.setup({
  sort_by = "name",
  hijack_netrw = true,
  view = {
    adaptive_size = true,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
        { key = { "<cr>" }, action = "edit", mode = "n" },
        { key = { "r" }, action = "rename", mode = "n" },
        { key = { "r" }, action = "rename", mode = "n" },
        { key = { "v", "s" }, action = "vsplit", mode = "n" },
        { key = { "x" }, action = "split", mode = "n" },
        { key = { "t" }, action = "tabnew", mode = "n" },
        { key = { "a" }, action = "create", mode = "n" },
        { key = { "D" }, action = "trash", mode = "n" },
        { key = { "m" }, action = "toggle_help", mode = "n" },
      }
    }
  },
  renderer = {
    highlight_git = true,
    icons = {
      webdev_colors = true,
      git_placement = "before",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      }
    },
    special_files = {
      "Cargo.toml",
      "Makefile",
      "README.md",
      "readme.md",
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  filesystem_watchers = {
    enable = false,
    interval = 100,
    debounce_delay = 50,
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  }
})
