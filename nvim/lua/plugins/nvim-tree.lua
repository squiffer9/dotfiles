-- Nvim-Tree Configuration
-- Setup for file explorer

-- Disable netrw at the very start for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit colors
vim.opt.termguicolors = true

-- Configure nvim-tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  hijack_cursor = true,
  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },
  filters = {
    dotfiles = false,  -- Show dotfiles
    custom = { "^.git$", "node_modules", "^.cache$" },  -- Hide .git folder, node_modules, and .cache
    exclude = {},  -- Keep all files not explicitly excluded
  },
  git = {
    enable = true,
    ignore = false,  -- Don't ignore git ignored files
    timeout = 400,
  },
  actions = {
    open_file = {
      quit_on_open = false,  -- Don't close the tree when opening a file
      resize_window = true,  -- Resize the window when opening a file
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  view = {
    width = 30,
    side = "left",
    preserve_window_proportions = false,
    signcolumn = "yes",
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    
    -- Key bindings
    local function map(mode, key, cmd, desc)
      vim.keymap.set(mode, key, cmd, { 
        desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true 
      })
    end
    
    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)
    
    -- Custom mappings
    map("n", "l", api.node.open.edit, "Open")
    map("n", "h", api.node.navigate.parent_close, "Close Directory")
    map("n", "v", api.node.open.vertical, "Open: Vertical Split")
    map("n", "s", api.node.open.horizontal, "Open: Horizontal Split")
    map("n", "H", api.tree.toggle_hidden_filter, "Toggle Dotfiles")
    map("n", "R", api.tree.reload, "Refresh")
    map("n", "?", api.tree.toggle_help, "Help")
    map("n", "C", api.tree.change_root_to_node, "CD")
    map("n", "P", api.node.navigate.parent, "Parent Directory")
  end,
})
