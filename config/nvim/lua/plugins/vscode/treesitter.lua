return {
	"nvim-treesitter/nvim-treesitter",
	enabled = false,
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = { "bash", "c", "lua", "python", "markdown" },
		sync_install = true,
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
