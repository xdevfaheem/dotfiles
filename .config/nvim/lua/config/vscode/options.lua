vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- gloal var for format on save
vim.g.autoformat = true
vim.g.disable_autoformat = false

-- disable snack animation
vim.g.snacks_animate = false

-- python xecutable for nvim (https://neovim.io/doc/user/provider.html#python-virtualenv)
vim.g.python3_host_prog = "/home/faheem/miniconda3/envs/nvim/bin/python3"

-- Reserve a space (two column) in the gutter (:help sign-column)
vim.opt.signcolumn = "yes"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- confirm to save changes before exiting modified buffer
vim.opt.confirm = true

vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

-- global statusline
vim.opt.laststatus = 3

-- wrap lines at convinient points
vim.opt.linebreak = true

-- disable line wrap
vim.opt.wrap = false

-- list of languages for internal spell checker
vim.opt.spelllang = { "en" }

vim.opt.smoothscroll = true

-- fold expression used to format a range of lines (:help formatexpr)
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- diagnostic signs
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
})
