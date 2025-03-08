-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key
vim.g.mapleader = " "

-- Hide line numbers in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end
})

-- Show line numbers when leaving terminal mode
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.opt_local.number = true
      vim.opt_local.relativenumber = true
    end
  end
})

-- Plugin configuration
require("lazy").setup({
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls", "solargraph", "pyright", "clangd", "rust_analyzer",
          "html", "cssls", "tsserver", "yamlls", "jsonls",
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function on_attach(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      local servers = {
        "gopls", "solargraph", "pyright", "clangd", "rust_analyzer",
        "html", "cssls", "yamlls", "jsonls", "tsserver"
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end
    end
  },

  -- nvim-tree configuration
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        update_focused_file = { enable = true },
        filters = { custom = { ".git" } },
      })
    end
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "lucius" }
      })
    end
  },

  -- Diagnostic configuration
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "ruby", "python", "cpp", "rust", "c", "lua", "html", "css", "javascript", "typescript", "yaml", "json" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
})

-- GitHub Copilot Settings
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

-- Diagnostic display settings
vim.diagnostic.config({
  virtual_text = false,
  float = { border = "rounded" },
})

-- Key mappings
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":confirm q<CR>", { noremap = true, silent = true })

-- Status message
print("Neovim configuration loaded successfully!")
