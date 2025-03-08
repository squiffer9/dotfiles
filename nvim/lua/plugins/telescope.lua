-- Telescope Configuration
-- Setup for fuzzy finder

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

-- Configure telescope
telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules", ".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
      "%.pdf", "%.mkv", "%.mp4", "%.zip", ".DS_Store"
    },
    layout_config = {
      horizontal = {
        width = 0.9,
        preview_width = 0.6,
      },
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        
        ["<C-c>"] = actions.close,
        ["<Esc>"] = actions.close,
        
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
        
        -- File browser extension specific mappings
        ["<C-b>"] = actions.results_scrolling_up,
        ["<C-f>"] = actions.results_scrolling_down,
      },
      
      n = {
        ["<C-c>"] = actions.close,
        ["<Esc>"] = actions.close,
        
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
        
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
      },
    },
  },
  
  pickers = {
    find_files = {
      hidden = true,  -- Include hidden files
      no_ignore = false,  -- Respect .gitignore
    },
    live_grep = {
      additional_args = function()
        return { "--hidden" }  -- Include hidden files in grep
      end,
    },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
  },
  
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- Load telescope extensions
telescope.load_extension("fzf")

-- Create global functions for common telescope operations
_G.telescope_find_files_in_path = function(path, opts)
  local _opts = opts or {}
  _opts.cwd = path
  builtin.find_files(_opts)
end

_G.telescope_live_grep_in_path = function(path, opts)
  local _opts = opts or {}
  _opts.cwd = path
  builtin.live_grep(_opts)
end

-- Additional key mappings
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Find recently opened files" })
vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Fuzzy search in current buffer" })

-- Search functions
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Resume last search" })
vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "Search commands" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "Search man pages" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current word" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search select telescope" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
vim.keymap.set("n", "<leader>st", builtin.colorscheme, { desc = "Search themes" })
