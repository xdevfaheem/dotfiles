-- Set default root markers for all clients
vim.lsp.config("*", { root_markers = { ".git" } })

-- Configs
local ls_config_map = {

	-- ty language server for python
	ty = {
		cmd = { "ty", "server" },
		filetypes = { "python" },
		settings = {
			ty = {
				diagnosticMode = "openFilesOnly",
				inlayHints = {
					variableTypes = true, -- variables types as inline hints
					callArgumentNames = true, -- args name in call as inline hints
				},
				completions = {
					autoImport = false, -- auto import suggestions
				},
			},
		},
		root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	},

	-- lua language server
	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = {
			".luarc.json",
			".luarc.jsonc",
			".luacheckrc",
			".stylua.toml",
			"stylua.toml",
			"selene.toml",
			"selene.yml",
			".git",
		},
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = {
						"lua/?.lua",
						"lua/?/init.lua",
					},
				},
				completion = {
					enable = true,
				},
				diagnostics = {
					enable = true,
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
			},
		},
	},
}

for server, config in pairs(ls_config_map) do
	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end

-- Keymaps
local map = vim.keymap.set
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Auto command on attach
local completion = vim.g.completion_mode or "blink" -- or 'native' for built-in completion
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		-- Enable built-in completion (if using native cmp)
		if completion == "native" and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				autotrigger = true, -- (on trigger chars set by lsp)
				convert = function(item)
					return { abbr = item.label:gsub("%b()", "") }
				end,
			})
		end

		-- Inlay hints
		if client:supports_method("textDocument/inlayHints") then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end

		if client:supports_method("textDocument/documentColor") then
			vim.lsp.document_color.enable(true, args.buf, {
				style = "background", -- 'background', 'foreground', or 'virtual'
			})
		end
	end,
})
