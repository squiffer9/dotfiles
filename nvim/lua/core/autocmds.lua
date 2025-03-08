-- Autocommands configuration
-- Contains all the autocommands for Neovim

-- Create augroup for easier management
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("terminal"),
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_position"),
  pattern = "*",
  callback = function()
    local line = vim.fn.line
    if line("'\"") > 1 and line("'\"") <= line("$") then
      vim.cmd("normal! g'\"")
    end
  end
})

-- Show line numbers in normal buffers
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("numbertoggle"),
  pattern = "*",
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.opt_local.number = true
      vim.opt_local.relativenumber = true
    end
  end
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end
})

-- Auto-format on save (if LSP is attached)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_format"),
  callback = function()
    -- Check if LSP formatting is available
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    for _, client in pairs(clients) do
      if client.supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ async = false })
        break
      end
    end
  end
})

-- Auto-resize windows when Neovim is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end
})

-- Automatically close quickfix window when selecting an item
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("quickfix_autoclose"),
  pattern = "qf",
  callback = function()
    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = 0,
      callback = function()
        vim.cmd("cclose")
      end,
      once = true,
    })
  end
})

-- Set filetype-specific options
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("filetype_settings"),
  pattern = { "go" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("filetype_settings"),
  pattern = { "yaml", "json", "html", "css", "scss", "javascript", "typescript" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

-- Check for file changes when focusing Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = augroup("checktime"),
  pattern = "*",
  command = "checktime"
})
