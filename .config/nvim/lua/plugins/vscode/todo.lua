return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = false,
	opts = {
		keywords = {
			FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "LOOK" } },
			TODO = { icon = " ", color = "info" },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		},
	},
	config = function(_, opts)
		-- intialize
		require("todo-comments").setup({ opts })

		-- set keymaps
		vim.keymap.set("n", "nt", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "pt", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous todo comment" })
	end,
}
