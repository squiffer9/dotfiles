-- Treesitter Configuration
-- Setup for syntax highlighting and code parsing

require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
    "lua", "vim", "vimdoc", "query",  -- Neovim related
    "go", "ruby", "python", "cpp", "rust", "c",  -- Main languages
    "html", "css", "javascript", "typescript", "tsx",  -- Web development
    "yaml", "json", "toml",  -- Configuration formats
    "markdown", "markdown_inline",  -- Documentation
    "bash", "dockerfile", "regex",  -- System and tools
    "git_rebase", "gitcommit", "gitignore",  -- Git related
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  -- Highlight configuration
  highlight = {
    enable = true,
    
    -- Disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Indentation configuration
  indent = {
    enable = true,
  },

  -- Incremental selection based on syntax tree
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },

  -- Code folding
  fold = {
    enable = true
  },

  -- Treesitter text objects
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["as"] = "@statement.outer",
        ["is"] = "@statement.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- Whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.outer",
        ["]l"] = "@loop.outer",
        ["]i"] = "@conditional.outer",
        ["]b"] = "@block.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]A"] = "@parameter.outer",
        ["]L"] = "@loop.outer",
        ["]I"] = "@conditional.outer",
        ["]B"] = "@block.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.outer",
        ["[l"] = "@loop.outer",
        ["[i"] = "@conditional.outer",
        ["[b"] = "@block.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[A"] = "@parameter.outer",
        ["[L"] = "@loop.outer",
        ["[I"] = "@conditional.outer",
        ["[B"] = "@block.outer",
      },
    },
  },

  -- Context aware commenting
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})

-- Enable folding with Treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false  -- Don't fold by default when opening files
