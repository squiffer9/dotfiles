-- LSP Configuration
-- Setup for Language Server Protocol clients

-- Initialize key components
local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local neodev = require("neodev")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local null_ls = require("null-ls")

-- Setup Mason for easy LSP installation
mason.setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Enable Lua language server for Neovim development
neodev.setup()

-- Configure available servers
mason_lspconfig.setup({
	ensure_installed = {
		"gopls", -- Go
		"solargraph", -- Ruby
		"pyright", -- Python
		"clangd", -- C/C++
		"rust_analyzer", -- Rust
		"html", -- HTML
		"cssls", -- CSS
		"ts_ls", -- TypeScript/JavaScript
		"yamlls", -- YAML
		"jsonls", -- JSON
		"lua_ls", -- Lua
		"tailwindcss", -- Tailwind CSS
		"dockerls", -- Docker
		"bashls", -- Bash
		"terraform_ls", -- Terraform
	},
	automatic_installation = true,
})

-- Configure diagnostic display
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focused = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Add icons to diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Define custom on_attach function
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	-- LSP keybindings
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
	end

	-- Mappings
	map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
	map("n", "gd", vim.lsp.buf.definition, "Go to definition")
	map("n", "K", vim.lsp.buf.hover, "Hover documentation")
	map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
	map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
	map("n", "<leader>D", vim.lsp.buf.type_definition, "Type definition")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
	map("n", "gr", vim.lsp.buf.references, "Go to references")
	map("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, "Format document")
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "List workspace folders")

	-- Diagnostics navigation
	map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
	map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
	map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")
	map("n", "<leader>q", vim.diagnostic.setloclist, "Set diagnostics to location list")

	-- Disable formatting for certain servers (we'll use null-ls for these)
	if client.name == "ts_ls" or client.name == "gopls" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
end

-- Define capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Setup each language server
local servers = {
	"gopls",
	"solargraph",
	"pyright",
	"clangd",
	"rust_analyzer",
	"html",
	"cssls",
	"yamlls",
	"jsonls",
	"ts_ls",
	"lua_ls",
	"tailwindcss",
	"dockerls",
	"bashls",
	"terraform_ls",
}

-- Default server configuration
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Special configurations for specific servers
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})

-- Setup null-ls for formatters and linters
null_ls.setup({
	sources = {
		-- Formatters
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.terraform_fmt,

		-- Linters
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.shellcheck,
	},
	on_attach = on_attach,
})
