-- gitsigns.nvim - Shows git changes in the sign column. Blame lines. Stage hunks. Navigate changes.
-- diffview.nvim - View diffs in a split. Compare branches. See file history. Review changes before commit. Resolve conflicts
vim.pack.add({
	"https://github.com/sindrets/diffview.nvim",
})


-- Setup diffview.nvim
require("diffview").setup({
	use_icons = true,
	icons = { folder_closed = "", folder_open = "" },
	view = {
		default = { winbar_info = true },
	},
	file_panel = {
		win_config = { height = 20 },
	},
})

-- diffview keymaps
vim.keymap.set("n", "<leader>Do", function()
	vim.ui.input({ prompt = "Diff refs (ex. main..feature): " }, function(refs)
		if refs and refs:match("%S") then
			local safe = vim.fn.shellescape(refs, true)
			vim.cmd(("DiffviewOpen %s"):format(safe))
		else
			vim.cmd("DiffviewOpen")
		end
	end)
end, { desc = "Diffview: open (prompt for refs or default)" })

vim.keymap.set("n", "<leader>Dc", "<cmd>DiffviewClose<cr>", { desc = "Diffview: Close" })
vim.keymap.set("n", "<leader>Dt", "<cmd>DiffviewToggleFiles<cr>", { desc = "Diffview: Toggle file list" })
vim.keymap.set("n", "<leader>Dh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview: File history" })
vim.keymap.set("n", "<leader>DH", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview: Repo history" })
