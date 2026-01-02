if vim.g.vscode then
	-- vim options and settings
	require("config.vscode.options")

	-- auto commands which triggers based on event
	require("config.vscode.autocmds")

	-- setup and load lazynvim and plugins
	-- require("config.vscode.lazyconfig")

	-- vim keymaps and for plugins
	require("config.vscode.keymaps")
else
	-- vim options and settings
	require("config.nvim.options")

	-- auto commands which triggers based on event
	require("config.nvim.autocmds")

	-- setup and load lazynvim and plugins
	require("config.nvim.lazyconfig")

	-- vim keymaps and for plugins
	require("config.nvim.keymaps")
end
