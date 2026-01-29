-- diagnostic settings
local map = vim.keymap.set

local palette = {
	err = "#51202A",
	warn = "#3B3B1B",
	info = "#1F3342",
	hint = "#1E2E1E",
}

vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { bg = palette.err, blend = 20 })
vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { bg = palette.warn, blend = 15 })
vim.api.nvim_set_hl(0, "DiagnosticInfoLine", { bg = palette.info, blend = 10 })
vim.api.nvim_set_hl(0, "DiagnosticHintLine", { bg = palette.hint, blend = 10 })

vim.api.nvim_set_hl(0, "DapBreakpointSign", { fg = "#FF0000", bg = nil, bold = true })
vim.fn.sign_define("DapBreakpoint", {
	text = "●", -- a large dot; change as desired
	texthl = "DapBreakpointSign", -- the highlight group you just defined
	linehl = "", -- no full-line highlight
	numhl = "", -- no number-column highlight
})

local sev = vim.diagnostic.severity

vim.diagnostic.config({
	underline = { severity = vim.diagnostic.severity.ERROR },
	severity_sort = true,
	update_in_insert = false, -- less flicker
	float = {
		border = "rounded",
		source = "if_many",
	},
	-- keep signs & virtual text, but tune them as you like
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	virtual_lines = false,
	-- dim whole line
	linehl = {
		[sev.ERROR] = "DiagnosticErrorLine",
		[sev.WARN] = "DiagnosticWarnLine",
		[sev.INFO] = "DiagnosticInfoLine",
		[sev.HINT] = "DiagnosticHintLine",
	},
	-- auto open the float for diagnostics, like when doing ]d
	jump = { float = true },
})

-- keymaps
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end

map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
map('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
