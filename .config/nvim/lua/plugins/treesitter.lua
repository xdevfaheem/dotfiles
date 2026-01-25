vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		data = {
			on_update = function()
				vim.cmd("TSUpdate") -- recommended in the repo
			end,
		},
	},
})
local ft_parsers = {
	"python",
	"lua",
	"luadoc",
	"comment",
	"diff",
	"markdown",
	"query",
	"vim",
	"vimdoc",
}
require("nvim-treesitter").install(ft_parsers)
vim.api.nvim_create_autocmd("FileType", {
	pattern = ft_parsers,
	callback = function()
		-- use treesitter for code folding (folds more accurately as ts now structures very well)
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

		-- use treesitter for indentation (much better than general based on brackets)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		-- load the parser, start syntax hightlighting
		local filetype = vim.bo.filetype
		if filetype and filetype ~= "" then
			pcall(vim.treesitter.start)
		end
	end,
})
