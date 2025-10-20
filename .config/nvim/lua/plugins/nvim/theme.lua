return {
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		enabled = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				-- Enable transparent background
				transparent = false,

				-- Enable italics comments
				italic_comments = false,

				-- Replace all fillchars with ' ' for the ultimate clean look
				hide_fillchars = false,
			})

			vim.cmd.colorscheme("cyberdream")
		end,
	},

	{
		"projekt0n/github-nvim-theme",
		enabled = true,
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				options = {
					styles = {
						comments = "italic",
						keywords = "bold",
						types = "italic,bold",
						functions = "bold",
					},
				},
			})

			vim.cmd("colorscheme github_dark_dimmed")
		end,
	},
}
