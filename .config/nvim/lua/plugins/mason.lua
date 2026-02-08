-- Mason setup for managing third-party binary (external tools such as LSPs, Linters, Formatters, etc)
vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-tool-installer").setup({
	ensure_installed = {
		-- lsp
		"lua-language-server",
		"ty",
		-- formatters
		"stylua",
		"ruff", --also a linter
		"shfmt",
		-- linters
		"codespell",
	},
})
