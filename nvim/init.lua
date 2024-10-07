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
          "html", "cssls", "ts_ls", "yamlls", "jsonls",
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = {
        "gopls", "solargraph", "pyright", "clangd", "rust_analyzer",
        "html", "cssls", "yamlls", "jsonls", "ts_ls"
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end
    end
  },

  -- SchemaStore
  { "b0o/schemastore.nvim" },

  -- Linter and Formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Linters
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.diagnostics.pylint,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.cppcheck,
          null_ls.builtins.diagnostics.yamllint,
          -- Formatters
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.rustfmt,
        },
      })
    end,
  },
  
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }),
        experimental = {
          ghost_text = true,
        },
      })
    end
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Previous()', { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next()', { silent = true, expr = true })
    end
  },
  
  -- Syntax highlighting
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
  
  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { width = 30 },
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
        },
        filters = { dotfiles = true },
      })
    end
  },
  
  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Color scheme
  {
    "jonathanfilip/vim-lucius",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme lucius]]
      vim.cmd[[LuciusDarkHighContrast]]
    end
  },

  -- Indentation guide
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = true, show_end = true },
    },
  },

  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
      { "<leader>gs", ":Git<CR>", desc = "Git status" },
      { "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
      { "<leader>gp", ":Git push<CR>", desc = "Git push" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
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
          lualine_c = {'filename'},
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
    end
  },
})

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

-- Key mappings
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cs", function()
  if vim.fn.exists("*copilot#Enabled") == 1 then
    local status = vim.fn["copilot#Enabled"]()
    print("Copilot status: " .. (status == 1 and "enabled" or "disabled"))
  else
    print("Copilot is not available")
  end
end, { noremap = true, silent = true, desc = "Check Copilot Status" })
vim.keymap.set("n", "<leader>ct", function()
  if vim.fn.exists("*copilot#Toggle") == 1 then
    vim.fn["copilot#Toggle"]()
    local status = vim.fn["copilot#Enabled"]()
    print("Copilot is now " .. (status == 1 and "enabled" or "disabled"))
  else
    print("Copilot toggle function is not available")
  end
end, { noremap = true, silent = true, desc = "Toggle Copilot" })

-- Git-related keymaps
vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { noremap = true, silent = true, desc = "Toggle git blame" })
vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<CR>", { noremap = true, silent = true, desc = "Git diff" })
vim.keymap.set("n", "]c", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true, desc = "Next git hunk" })
vim.keymap.set("n", "[c", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true, desc = "Previous git hunk" })

-- Custom LSP key mappings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Auto format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Hybrid line numbers (both relative and absolute)
vim.wo.number = true
vim.wo.relativenumber = true

-- Always show the signcolumn
vim.opt.signcolumn = "yes"

-- Set updatetime for CursorHold
vim.opt.updatetime = 300

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Set completeopt for better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append "c"

-- Set up diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Additional Telescope key mappings
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<CR>', { noremap = true, silent = true })

-- Toggle terminal
vim.keymap.set('n', '<leader>t', ':terminal<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Quick save
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })

-- Quick quit
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })

-- Move between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Resize windows
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Move lines up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Clear search highlighting
vim.keymap.set('n', '<leader>/', ':noh<CR>', { noremap = true, silent = true })

-- Toggle spell checking
vim.keymap.set('n', '<leader>s', ':setlocal spell!<CR>', { noremap = true, silent = true })

-- Open init.lua for quick editing
vim.keymap.set('n', '<leader>ve', ':e $MYVIMRC<CR>', { noremap = true, silent = true })

-- Source (reload) init.lua
vim.keymap.set('n', '<leader>vs', ':source $MYVIMRC<CR>', { noremap = true, silent = true })

-- Print current filename
vim.keymap.set('n', '<leader>fn', ':echo expand("%:p")<CR>', { noremap = true, silent = true })

-- Toggle wrap
vim.keymap.set('n', '<leader>tw', ':set wrap!<CR>', { noremap = true, silent = true })

-- Center cursor when scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- Keep cursor centered when searching
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

print("Neovim configuration loaded successfully!")
