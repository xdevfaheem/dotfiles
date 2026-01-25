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

		-- ["<S-Tab>"] = { "select_prev", "fallback" },
		-- ["<Tab>"] = { "select_next", "fallback" },
		-- ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
		-- ["<C-n>"] = { "select_next", "fallback_to_mappings" },

		["<Up>"] = { "scroll_documentation_down", "fallback" },
		["<Down>"] = { "scroll_documentation_up", "fallback" },

		-- ["<CR>"] = {
		-- 	function(cmp)
		-- 		if cmp.snippet_active() then
		-- 			return cmp.accept()
		-- 		else
		-- 			return cmp.select_and_accept()
		-- 		end
		-- 	end,
		-- 	"snippet_forward",
		-- 	"fallback",
		-- },
	},
	appearance = {
		nerd_font_variant = "mono",
		use_nvim_cmp_as_default = true,
	},

	completion = {
		trigger = { show_on_trigger_character = true, show_in_snippet = false },
		keyword = { range = "prefix" },
		accept = { auto_brackets = { enabled = true } },
		list = { selection = { preselect = false, auto_insert = false } },
		ghost_text = { enabled = true },
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
})
