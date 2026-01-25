-- Python LSP config
---@type vim.lsp.Config
return {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
}

-- basedpyright config
-- local function set_python_path(command)
-- 	local path = command.args
-- 	local clients = vim.lsp.get_clients({
-- 		bufnr = vim.api.nvim_get_current_buf(),
-- 		name = "basedpyright",
-- 	})
-- 	for _, client in ipairs(clients) do
-- 		if client.settings then
-- 			---@diagnostic disable-next-line: param-type-mismatch
-- 			client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {}, { pythonPath = path })
-- 		else
-- 			client.config.settings =
-- 				vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
-- 		end
-- 		client:notify("workspace/didChangeConfiguration", { settings = nil })
-- 	end
-- end
--
-- ---@type vim.lsp.Config
-- return {
-- 	cmd = { "basedpyright-langserver", "--stdio" },
-- 	filetypes = { "python" },
-- 	root_markers = {
-- 		"pyproject.toml",
-- 		"requirements.txt",
-- 		".git",
-- 	},
-- 	settings = {
-- 		basedpyright = {
-- 			analysis = {
-- 				autoSearchPaths = true,
-- 				useLibraryCodeForTypes = true,
-- 				diagnosticMode = "openFilesOnly",
-- 			},
-- 		},
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
-- 			desc = "Reconfigure basedpyright with the provided python path",
-- 			nargs = 1,
-- 			complete = "file",
-- 		})
-- 	end,
-- }
