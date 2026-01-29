vim.g.mapleader = vim.keycode("<Space>")
vim.g.maplocalleader = vim.keycode("<Space>")
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>')

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- clear search highlights
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- yank to end of line
map("n", "Y", "y$")

-- Better paste (doesn't replace clipboard with deleted text)
map("v", "p", '"_dP', opts)

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Center screen when jumping
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting
map("n", "<C-w>v", "<cmd>vsplit<cr>", { desc = "Split window vertically" })
map("n", "<C-w>h", "<cmd>split<cr>", { desc = "Split window horizontally" })

-- Resizing
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })

-- Move lines up/down
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Buffers
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
local function smart_close_buffer() -- Function to close buffer but keep tab if it's the only buffer in tab
	local buffers_in_tab = #vim.fn.tabpagebuflist()
	if buffers_in_tab > 1 then
		vim.cmd("bdelete")
	else
		-- If it's the only buffer in tab, close the tab
		vim.cmd("tabclose")
	end
end
map("n", "<leader>bq", smart_close_buffer, { desc = "Smart close buffer/tab" })

-- Tabs
map("n", "<tab>c", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<tab>q", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<tab>n", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<tab>p", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
local function open_file_in_tab()
	vim.ui.input({ prompt = "File to open in new tab: ", completion = "file" }, function(input)
		if input and input ~= "" then
			vim.cmd("tabnew " .. input)
		end
	end)
end
map("n", "<tab>o", open_file_in_tab, { desc = "Open file in new tab" })

-- Smart undo break-points (create undo points at logical stops)
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Quick file navigation
-- flick netrw file explorer (ditch neotree bloat bs)
map("n", "\\", "<cmd>Lexplore! 15<cr>", opts)
map("n", "<leader>ff", ":find ", { desc = "Find file" })

-- vim.pack plugins update
vim.keymap.set("n", "<leader>pu", "<cmd>lua vim.pack.update()<CR>")
