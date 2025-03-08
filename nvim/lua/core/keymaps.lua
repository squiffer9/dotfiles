-- Keymaps configuration
-- Contains all the custom keybindings

-- Helper function for mapping keys
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Clear search highlighting
map("n", "<leader>/", ":nohlsearch<CR>")

-- Buffer navigation
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":confirm q<CR>", { desc = "Quit" })
map("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Navigate to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Navigate to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Navigate to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Navigate to right window" })

-- Resize windows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move lines up and down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Terminal navigation
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>t", ":terminal<CR>", { desc = "Open terminal" })

-- Center search results
map("n", "n", "nzzzv", { desc = "Center screen when navigating search results" })
map("n", "N", "Nzzzv", { desc = "Center screen when navigating search results" })
map("n", "<C-d>", "<C-d>zz", { desc = "Center screen when scrolling down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Center screen when scrolling up" })

-- Quick edit and source configuration
map("n", "<leader>ve", ":edit $MYVIMRC<CR>", { desc = "Edit Neovim config" })
map("n", "<leader>vs", ":source $MYVIMRC<CR>", { desc = "Reload Neovim config" })

-- File explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Fuzzy finding with Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Find help tags" })
map("n", "<leader>fo", ":Telescope oldfiles<CR>", { desc = "Find recent files" })

-- LSP keybindings (will be attached to buffers with LSP)
-- These are defined in plugins/lsp.lua

-- GitHub Copilot keybindings
map("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
map("i", "<C-H>", 'copilot#Previous()', { expr = true, silent = true })
map("i", "<C-K>", 'copilot#Next()', { expr = true, silent = true })

-- Toggle settings
map("n", "<leader>tw", ":set wrap!<CR>", { desc = "Toggle line wrap" })
map("n", "<leader>s", ":setlocal spell!<CR>", { desc = "Toggle spell checking" })

-- Get filename
map("n", "<leader>fn", ":echo expand('%:p')<CR>", { desc = "Show current file path" })

-- Git integrations (for fugitive and gitsigns)
map("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
map("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
map("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle git blame" })
map("n", "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "Git diff" })
map("n", "]c", ":Gitsigns next_hunk<CR>", { desc = "Next git hunk" })
map("n", "[c", ":Gitsigns prev_hunk<CR>", { desc = "Previous git hunk" })
