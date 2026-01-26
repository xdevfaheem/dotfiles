local opt = vim.opt

-- Basic settings
opt.number = true -- Absolute line numbers (cursor position)
opt.relativenumber = true -- Relative line numbers (distance from cursor)
opt.cursorline = true -- Highlight current line
opt.wrap = true -- wrap lines
opt.linebreak = true -- Wrap lines at convenient points
opt.scrolloff = 10 -- Keep 10 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
opt.confirm = true -- confirm to save changes before exiting modified buffer

-- Indentation
opt.tabstop = 4 -- no. of space tab counts when opening a file (indents, wherever tab key is used tabstop number of spaces will be there)
opt.softtabstop = 4 -- no. of spaces Tab counts for when editing (using tab key on insert)
opt.shiftwidth = 4 -- Indent width
opt.shiftround = true -- round indent to multiple of shiftwidth
opt.expandtab = false -- Use tabs as it is (not spaces)
opt.smartindent = true -- Smart auto-indenting on new lines
opt.autoindent = true -- Copy indent from current line
opt.breakindent = true -- continue having same indent while wrapping

-- Search settings
opt.ignorecase = false -- Case insensitive search
opt.smartcase = true -- Case sensitive if uppercase in search
opt.hlsearch = false -- don't highlight results of previous search, its great

-- Visual settings
opt.list = true -- Show whitespace characters
opt.signcolumn = "yes:1" -- Always show sign column (on the left, like for diagnostic)
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 2 -- How long to show matching bracket
opt.cmdheight = 1 -- no command line, it replace last line when used
opt.showmode = false -- disable mode in last line as lualine show that rn
opt.completeopt = { "menuone", "noselect", "popup" } -- Completion options
opt.shortmess:append("c")
opt.pumheight = 10 -- Popup menu height (num entries)
opt.pumblend = 10 -- Popup menu transparency
opt.lazyredraw = true -- Don't redraw during macros
opt.synmaxcol = 200 -- Syntax highlighting limit
opt.inccommand = "split" -- Preview substitutions live, as you type!
opt.laststatus = 2 -- status line in last window (:help laststatus)
opt.winborder = "rounded" -- window's border should be rounded to make stand out

-- File handling
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
opt.updatetime = 250 -- Faster completion
opt.timeoutlen = 500 -- Key timeout duration (mapped sequence wait time)
opt.ttimeoutlen = 0 -- Key code timeout

-- Behavior settings
opt.hidden = true -- Allow hidden buffers
opt.errorbells = true
opt.visualbell = true -- visual bell (screen flash) on errors
opt.iskeyword:append("-") -- Treat dash as part of word
opt.path:append("**") -- include subdirectories in search
opt.selection = "exclusive" -- Selection behavior
opt.mouse = "a" -- Enable mouse support
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus" -- Sync with system clipboard

-- Folding settings
opt.foldmethod = "expr" -- Use expression for folding
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding
opt.foldlevel = 99 -- Start with all folds open

-- Split behavior
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right

-- Command-line completion
opt.wildmenu = true
opt.wildmode = "longest:full,full" -- should dwelve deeper
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
opt.diffopt:append("linematch:60")

-- Performance improvements
opt.redrawtime = 10000
opt.maxmempattern = 20000

-- netrw config
vim.g.netrw_keepdir = 0
vim.g.netrw_browse_split = 3 -- open file in new tab
vim.g.netrw_liststyle = 3 -- tree style
vim.g.netrw_altv = 1
vim.g.netrw_banner = 0 -- disable banner

-- diable provider-python
vim.g.loaded_python3_provider = 0

opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
