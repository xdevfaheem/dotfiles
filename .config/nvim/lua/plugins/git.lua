-- gitsigns.nvim - Shows git changes in the sign column. Blame lines. Stage hunks. Navigate changes.
-- diffview.nvim - View diffs in a split. Compare branches. See file history. Review changes before commit. Resolve conflicts
vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/sindrets/diffview.nvim",
})

-- Setup gitsigns.nvim
require("gitsigns").setup({
	on_attach = function(buffer)
		local gs = require("gitsigns")

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
		end

		map("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, "Next Hunk")

		map("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, "Prev Hunk")

		map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
		map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")

		map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Stage Hunk (in visual mode)' )
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Reset Hunk (in visual mode)' )

		map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
		map("n", "<leader>hu", gs.stage_hunk, "Undo Stage Hunk")
		map("n", "<leader>hr", gs.reset_hunk,"Reset Hunk")

		map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
		map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")

		map("n", "<leader>hp", gs.preview_hunk_inline, "Preview Hunk Inline")

		map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
		map("n", "<leader>hB", function() gs.blame() end, "Blame Buffer")

		map("n", "<leader>hd", gs.diffthis, "Diff This")
		map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")

		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")

		map('n', '<leader>tb', gs.toggle_current_line_blame, "Toggle git blame line")
		map("n", "<leader>tG", function()
			local cfg = require("gitsigns.config").config
			local current = cfg.signcolumn
			gs.toggle_signs(not current)
		end, "Toggle git signs" )
	end,
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
vim.keymap.set("n", "<leader>tD", "<cmd>DiffviewToggleFiles<cr>", { desc = "Diffview: Toggle file list" })
vim.keymap.set("n", "<leader>Dh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview: File history" })
vim.keymap.set("n", "<leader>DH", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview: Repo history" })
