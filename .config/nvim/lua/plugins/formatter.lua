vim.pack.add({ "https://github.com/stevearc/conform.nvim.git" })
local conform = require("conform")
conform.setup({
	-- formatters per filetypes
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
		sh = { "shfmt" },
	},
	-- this would override the default values in .format() and format_on-save/after_save
	default_format_opts = {
		lsp_format = "fallback",
		timeout_ms = 500,
		async = false,
		quiet = false, -- indicates errors
	},
	["*"] = { "codespell" }, -- formatter for all type
	["_"] = { "trim_whitespace" }, -- formatter for fts with no formatters
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" -- use conform for code formatting
vim.keymap.set(
	{ "n", "v" },
	"<leader>cf",
	"<cmd>lua require('conform').format()<cr>",
	{ desc = "Format file or range" }
)
