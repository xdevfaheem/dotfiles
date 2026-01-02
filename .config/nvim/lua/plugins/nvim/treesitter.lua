return {
	"nvim-treesitter/nvim-treesitter",

	-- access lua api to update syncly
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,

	-- module to send the config to
	main = "nvim-treesitter.configs",

	-- options to send to the main module
	opts = {
		ensure_installed = { "bash", "c", "lua", "python", "markdown" },
		auto_instal = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
