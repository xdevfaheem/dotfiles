vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
})

require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
	keymap = {
		preset = "super-tab",

		["<Up>"] = { "scroll_documentation_down", "fallback" },
		["<Down>"] = { "scroll_documentation_up", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
		use_nvim_cmp_as_default = true,
	},

	completion = {
		trigger = { show_on_trigger_character = true, show_in_snippet = false },
		keyword = { range = "prefix" },
		accept = { auto_brackets = { enabled = true } },
		list = { selection = { preselect = true, auto_insert = false } },
		ghost_text = { enabled = true },
		documentation = { auto_show = true },
	},

	cmdline = {
		keymap = {
			preset = "inherit",
			["<Tab>"] = { "accept" },
			["<CR>"] = { "fallback" }, -- act as usual, prevent accepting cmp when doing :w ehen menu show wq, i can enter on :w
		},
		completion = {
			menu = {
				-- only show menu when writing commands or inputs
				auto_show = function(ctx)
					return vim.fn.getcmdtype() == ":" or vim.fn.getcmdtype() == "@"
				end,
			},
			ghost_text = { enabled = true },
		},
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
})
