vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })
require("tokyonight").setup({
	style = "moon",
	transparent = false,
})
vim.cmd.colorscheme("tokyonight")
