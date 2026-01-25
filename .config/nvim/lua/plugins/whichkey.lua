vim.pack.add({ "https://github.com/folke/which-key.nvim", "https://github.com/nvim-tree/nvim-web-devicons" })
require("which-key").setup({
	preset = "helix",
	icons = {
		mappings = false,
		keys = {
			Space = "Space",
			Esc = "Esc",
			BS = "Backspace",
			C = "Ctrl-",
		},
	},
})

require("which-key").add({
	{ "<tab>", group = "Tabs" },
	{ "<leader>c", group = "Code" },
	{ "g", group = "Go to" },
	{ "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = "󱖫 ", color = "green" } },
	{ "[", group = "Previous" },
	{ "]", group = "Next" },
	{
		"<leader>b",
		group = "buffer",
		expand = function()
			return require("which-key.extras").expand.buf()
		end,
	},
	{
		"<leader>w",
		group = "windows",
		proxy = "<c-w>",
		expand = function()
			return require("which-key.extras").expand.win()
		end,
	},
	{
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
})
