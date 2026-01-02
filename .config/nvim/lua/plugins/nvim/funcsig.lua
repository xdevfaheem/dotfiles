-- https://github.com/ray-x/lsp_signature.nvim#setup--attach-the-plugin
return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	enabled = false,
	opts = {
		bind = true,
		handler_opts = {
			border = "rounded",
		},
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
	end,
}
