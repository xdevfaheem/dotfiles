-- Set default root markers for all clients
vim.lsp.config("*", { root_markers = { ".git" } })


local lspgroup = vim.api.nvim_create_augroup("Lsp", {})

local completion = vim.g.completion_mode or "blink" -- or 'native' for built-in completion
vim.api.nvim_create_autocmd("LspAttach", {
	group = lspgroup,
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

	-- Enable built-in completion (if using native cmp)
		if completion == "native" and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				autotrigger = true,
				convert = function(item)
					return { abbr = item.label:gsub("%b()", "") }
				end,
			})
		end

		-- Inlay hints (toggle)
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

vim.lsp.enable({
	"python_ls",
	"lua_ls",
})
