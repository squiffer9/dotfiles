-- Core Neovim options
-- Contains all the basic settings for Neovim

-- UI settings
vim.opt.number = true                -- Show line numbers
vim.opt.relativenumber = true        -- Show relative line numbers
vim.opt.termguicolors = true         -- True color support
vim.opt.background = "dark"          -- Dark background
vim.opt.cursorline = true            -- Highlight current line
vim.opt.signcolumn = "yes"           -- Always show sign column
vim.opt.showmode = false             -- Don't show mode in command line (shown in statusline)
vim.opt.laststatus = 3               -- Global statusline
vim.opt.cmdheight = 1                -- Command line height
vim.opt.scrolloff = 8                -- Minimum lines to keep above/below cursor
vim.opt.sidescrolloff = 8            -- Minimum columns to keep left/right of cursor

-- Whitespace and indentation
vim.opt.expandtab = true             -- Use spaces instead of tabs
vim.opt.shiftwidth = 2               -- Number of spaces for indentation
vim.opt.tabstop = 2                  -- Number of spaces a tab counts for
vim.opt.softtabstop = 2              -- Number of spaces inserted for a tab
vim.opt.smartindent = true           -- Smart autoindenting
vim.opt.wrap = false                 -- Don't wrap lines
vim.opt.list = true                  -- Show some invisible characters
vim.opt.listchars:append("space:⋅")  -- Show spaces
vim.opt.listchars:append("eol:↴")    -- Show end of line

-- Search settings
vim.opt.ignorecase = true            -- Ignore case in search patterns
vim.opt.smartcase = true             -- Override ignorecase if search has uppercase
vim.opt.hlsearch = true              -- Highlight search results
vim.opt.incsearch = true             -- Incremental search
vim.opt.inccommand = "split"         -- Preview substitutions live

-- Editor behavior
vim.opt.hidden = true                -- Allow switching buffers without saving
vim.opt.autoread = true              -- Automatically read files changed outside of Vim
vim.opt.mouse = "a"                  -- Enable mouse support
vim.opt.clipboard = "unnamedplus"    -- Use system clipboard
vim.opt.updatetime = 250             -- Faster completion (default is 4000ms)
vim.opt.timeoutlen = 300             -- Time to wait for a mapped sequence to complete (default is 1000ms)
vim.opt.undofile = true              -- Persistent undo
vim.opt.backup = false               -- Don't create backup files
vim.opt.writebackup = false          -- Don't create backup files while editing
vim.opt.swapfile = false             -- Don't create swap files

-- Split behavior
vim.opt.splitbelow = true            -- Open new horizontal splits below current
vim.opt.splitright = true            -- Open new vertical splits to the right
vim.opt.equalalways = true           -- Make all windows equal size

-- Completion settings
vim.opt.completeopt = "menu,menuone,noselect"   -- Completion options
vim.opt.pumheight = 10               -- Max height of popup menu
vim.opt.shortmess:append("c")        -- Don't show "Pattern not found" messages

-- File encoding
vim.opt.fileencoding = "utf-8"       -- File encoding 
vim.opt.encoding = "utf-8"           -- Buffer encoding
