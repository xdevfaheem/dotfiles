vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim.git" })

require("lualine").setup({
	options = { theme = "auto" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "lsp_status", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
