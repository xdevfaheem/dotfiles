vim.pack.add({ "https://github.com/mfussenegger/nvim-lint.git" })
local lint = require("lint")
lint.linters_by_ft = {
	python = { "ruff" },
}
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
	callback = function()
		lint.try_lint()
	end,
})
vim.keymap.set("n", "<leader>cl", function()
	require("lint").try_lint()
end, { desc = "Trigger linting for current file" })
