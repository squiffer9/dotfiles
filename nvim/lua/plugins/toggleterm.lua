-- ToggleTerm Configuration
-- Setup for integrated terminal

require("toggleterm").setup({
  -- Size can be a number or function
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],  -- Key to toggle terminal
  hide_numbers = true,       -- Hide line numbers in terminal
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,        -- Percentage by which to shade terminal color, default: 1
  start_in_insert = true,    -- Start terminal in insert mode
  insert_mappings = true,    -- Whether or not insert mode mappings are enabled
  persist_size = true,
  direction = "float",       -- 'vertical' | 'horizontal' | 'tab' | 'float'
  close_on_exit = true,      -- Close the terminal window when the process exits
  shell = vim.o.shell,       -- Use the default shell
  float_opts = {
    border = "curved",       -- 'single' | 'double' | 'shadow' | 'curved'
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  },
  winbar = {
    enabled = false,
  },
})

-- Create specific terminals for common tasks
local Terminal = require("toggleterm.terminal").Terminal

-- Lazygit integration
local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "curved",
    width = function()
      return math.floor(vim.o.columns * 0.9)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.9)
    end,
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
})

function _G.toggle_lazygit()
  lazygit:toggle()
end

-- Node REPL
local node = Terminal:new({
  cmd = "node",
  hidden = true,
  direction = "float",
})

function _G.toggle_node()
  node:toggle()
end

-- Python REPL
local python = Terminal:new({
  cmd = "python",
  hidden = true,
  direction = "float",
})

function _G.toggle_python()
  python:toggle()
end

-- Htop process viewer
local htop = Terminal:new({
  cmd = "htop",
  hidden = true,
  direction = "float",
})

function _G.toggle_htop()
  htop:toggle()
end

-- Set terminal-specific keymaps
vim.keymap.set("n", "<leader>tg", "<cmd>lua toggle_lazygit()<CR>", {desc = "Open Lazygit"})
vim.keymap.set("n", "<leader>tn", "<cmd>lua toggle_node()<CR>", {desc = "Open Node REPL"})
vim.keymap.set("n", "<leader>tp", "<cmd>lua toggle_python()<CR>", {desc = "Open Python REPL"})
vim.keymap.set("n", "<leader>th", "<cmd>lua toggle_htop()<CR>", {desc = "Open Htop"})
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", {desc = "Open floating terminal"})
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", {desc = "Open vertical terminal"})
vim.keymap.set("n", "<leader>tb", "<cmd>ToggleTerm direction=horizontal<CR>", {desc = "Open horizontal terminal"})

-- Terminal navigation
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    local opts = {buffer = 0}
    vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
  end,
})
