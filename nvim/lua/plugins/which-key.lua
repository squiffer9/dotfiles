-- Which-key Configuration
-- Setup for key binding help popup

local wk = require("which-key")

wk.setup({
  plugins = {
    marks = true,         -- shows a list of your marks on ' and `
    registers = true,     -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,     -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20,   -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    presets = {
      operators = true,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,     -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,     -- default bindings on <c-w>
      nav = true,         -- misc bindings to work with windows
      z = true,           -- bindings for folds, spelling and others prefixed with z
      g = true,           -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow, rounded
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

-- Register key groups
wk.register({
  ["<leader>"] = {
    f = {
      name = "File/Find",
      f = { "Find file" },
      g = { "Find text" },
      b = { "Find buffer" },
      h = { "Find help" },
      o = { "Find recent files" },
    },
    g = {
      name = "Git",
      s = { "Git status" },
      c = { "Git commit" },
      p = { "Git push" },
      b = { "Toggle git blame" },
      d = { "Git diff" },
      t = {
        name = "Toggles",
        b = { "Toggle blame line" },
        d = { "Toggle deleted" }
      },
    },
    b = {
      name = "Buffer",
      d = { "Delete buffer" },
      n = { "Next buffer" },
      p = { "Previous buffer" },
    },
    t = {
      name = "Terminal",
      t = { "Toggle floating terminal" },
      v = { "Toggle vertical terminal" },
      b = { "Toggle horizontal terminal" },
      g = { "Lazygit" },
      n = { "Node REPL" },
      p = { "Python REPL" },
      h = { "Htop" },
    },
    w = { "Save file" },
    q = { "Quit" },
    e = { "File explorer" },
    v = {
      name = "Vim",
      e = { "Edit config" },
      s = { "Source config" },
    },
    s = {
      name = "Search",
      r = { "Resume last search" },
      c = { "Search commands" },
      k = { "Search keymaps" },
      m = { "Search man pages" },
      w = { "Search current word" },
      d = { "Search diagnostics" },
      s = { "Search telescope" },
      h = { "Search help" },
      t = { "Search themes" },
    },
    c = {
      name = "Code",
      a = { "Code action" },
      r = { "Rename" },
      f = { "Format" },
    },
    d = { "Go to definition" },
    r = { "Go to references" },
    t = {
      name = "Toggle",
      w = { "Toggle word wrap" },
      s = { "Toggle spell checking" },
    },
    ["/"] = { "Clear highlights" },
  },
})
