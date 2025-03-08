-- Which-key Configuration
-- Setup for key binding help popup

local wk = require("which-key")

wk.setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
	win = {
		border = "rounded",
		position = "bottom",
		margin = { 1, 0, 1, 0 },
		padding = { 2, 2, 2, 2 },
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 },
		width = { min = 20, max = 50 },
		spacing = 3,
		align = "left",
	},
	show_help = true,
	triggers = { "<leader>" },
})

wk.register({
	["/"] = { name = "Clear highlights" },
	b = {
		name = "Buffer",
		d = { name = "Delete buffer" },
		n = { name = "Next buffer" },
		p = { name = "Previous buffer" },
	},
	c = {
		name = "Code",
		a = { name = "Code action" },
		f = { name = "Format" },
		r = { name = "Rename" },
	},
	d = { name = "Go to definition" },
	e = { name = "File explorer" },
	f = {
		name = "File/Find",
		b = { name = "Find buffer" },
		f = { name = "Find file" },
		g = { name = "Find text" },
		h = { name = "Find help" },
		o = { name = "Find recent files" },
	},
	g = {
		name = "Git",
		b = { name = "Toggle git blame" },
		c = { name = "Git commit" },
		d = { name = "Git diff" },
		p = { name = "Git push" },
		s = { name = "Git status" },
		t = {
			name = "Toggles",
			b = { name = "Toggle blame line" },
			d = { name = "Toggle deleted" },
		},
	},
	q = { name = "Quit" },
	r = { name = "Go to references" },
	s = {
		name = "Search",
		c = { name = "Search commands" },
		d = { name = "Search diagnostics" },
		h = { name = "Search help" },
		k = { name = "Search keymaps" },
		m = { name = "Search man pages" },
		r = { name = "Resume last search" },
		s = { name = "Search telescope" },
		t = { name = "Search themes" },
		w = { name = "Search current word" },
	},
	t = {
		name = "Terminal",
		t = { name = "Open floating terminal" },
		n = { name = "Open Node REPL" },
		h = { name = "Open Htop" },
		p = { name = "Open Python REPL" },
		g = { name = "Open Lazygit" },
		v = { name = "Open vertical terminal" },
		b = { name = "Open horizontal terminal" },
		w = { name = "Toggle word wrap" },
		s = { name = "Toggle spell checking" },
	},
	v = {
		name = "Vim",
		e = { name = "Edit config" },
		s = { name = "Source config" },
	},
	w = {
		name = "Save file",
		a = { name = "Add workspace folder" },
		r = { name = "Remove workspace folder" },
		l = { name = "List workspace folders" },
	},
}, { prefix = "<leader>" })
