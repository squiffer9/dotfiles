-- Lualine Configuration
-- Setup for enhanced status line

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto", -- automatically adjusts based on colorscheme
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "NvimTree", "toggleterm" },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true, -- enable global status line
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { 
      { "mode", separator = { left = "" }, right_padding = 2 } 
    },
    lualine_b = { 
      { "branch", icon = "" },
      { 
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = "#98be65" },
          modified = { fg = "#ECBE7B" },
          removed = { fg = "#ec5f67" },
        },
      },
    },
    lualine_c = { 
      {
        "filename",
        file_status = true,      -- Shows file status (readonly, modified)
        path = 1,                -- 0 = just filename, 1 = relative path, 2 = absolute path
        shorting_target = 40,    -- Shorten path to leave 40 spaces for other components
        symbols = {
          modified = "[+]",      -- Text to show when file is modified
          readonly = "[RO]",     -- Text to show when file is readonly
          unnamed = "[No Name]", -- Text to show for unnamed buffers
        },
      },
    },
    lualine_x = { 
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        diagnostics_color = {
          error = { fg = "#ec5f67" },
          warn = { fg = "#ECBE7B" },
          info = { fg = "#008080" },
          hint = { fg = "#98be65" },
        },
      },
      { "encoding" },
      { "fileformat" },
      { "filetype", icon_only = false },
    },
    lualine_y = { "progress" },
    lualine_z = { 
      { "location", separator = { right = "" }, left_padding = 2 }
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {}, -- Using bufferline.nvim instead
  winbar = {},
  inactive_winbar = {},
  extensions = {
    "nvim-tree",
    "toggleterm",
    "fugitive",
    "quickfix",
  },
})
