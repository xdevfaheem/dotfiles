return {

	-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
	-- used for completion, annotations and signatures of Neovim apis
	{
		"folke/lazydev.nvim",
		ft = "lua",
		enabled=true,
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	-- Core LSP config
	{
		"neovim/nvim-lspconfig",
		enabled=true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			{ "j-hui/fidget.nvim", opts = {} }, -- little ui at the bottom right for lsp updates
			"saghen/blink.cmp", -- Allows extra capabilities provided by nvim-cmp
		},

		config = function()
			-- function to run when a LSP attach to a particular buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					-- keymap for the lsp
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "grn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

					-- highlight reference of the word under the cursor (just like in vscode if we rest the cursor)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

						-- show refrence if cursor rests
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						-- clear refernce if cursor moves from there
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						-- runs when LSP detaches from the buffer
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({
									group = "kickstart-lsp-highlight",
									buffer = event2.buf,
								})
							end,
						})
					end

					-- keymap to toggle inlay hint if lsp supports it
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						vim.keymap.set("n", "<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, opts)
					end
				end,
			})

			local lsp_config = require("lspconfig")

			-- extend the general server capabilities with custom config
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem = {
				documentationFormat = { "markdown", "plaintext" },
				snippetSupport = true,
				preselectSupport = true,
				insertReplaceSupport = true,
				labelDetailsSupport = true,
				deprecatedSupport = true,
				commitCharactersSupport = true,
				tagSupport = { valueSet = { 1 } },
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}
			-- merge the general lsp capabilties with blink cmp capabilities.
			capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

			-- lsp servers with its custom configuration
			local servers = {
				-- jedi_language_server = {},
				-- pylsp = {
				-- 	settings = {
				-- 		pylsp = {
				-- 			plugins = {
				-- 				-- formatter options
				-- 				black = { enabled = false },
				-- 				autopep8 = { enabled = false },
				-- 				yapf = { enabled = false },
				-- 				mccabe = { enabled = false },
				-- 				-- linter options
				-- 				pylint = { enabled = false, executable = "pylint" },
				-- 				pyflakes = { enabled = false },
				-- 				pycodestyle = { enabled = false },
				-- 				-- type checker
				-- 				pylsp_mypy = { enabled = false },
				-- 				-- auto-completion options
				-- 				jedi_completion = { fuzzy = false },
				-- 				rope_completion = { enabled = true },
				-- 				-- import sorting
				-- 				pyls_isort = { enabled = false },
				-- 			},
				-- 		},
				-- 	},
				-- },
				-- pylyzer = {},
				pyright = {},
				-- basedpyright = {
				--
				-- 	-- https://docs.basedpyright.com/latest/configuration/language-server-settings/
				-- 	settings = {
				-- 		-- python = {pythonPath = ""},
				-- 		basedpyright = {
				-- 			disableOrganizeImports = true, -- ruff handles this
				-- 			analysis = {
				-- 				autoImportCompletions = false, -- disable auto import completion
				-- 				autoSearchPaths = false,
				-- 				diagnosticMode = "openFilesOnly", -- analyze only open files
				-- 				useLibraryCodeForTypes = true, -- parse and analyze library code to extract type info
				-- 				inlayHints = { genericTypes = true },
				-- 				typeCheckingMode = "standard",
				-- 				extraPaths = { "~/projects/refine_my_resume/.venv/bin/python" },
				-- 			},
				-- 		},
				-- 	},
				-- },
				lua_ls = {},
			}

			-- loop through the defined LSPs and setup them
			for server, config in pairs(servers) do
			-- override the values in global server capabilities with custom server configuration (if defined above).
				-- Useful when disabling certain features of an LSP (for example, turning off formatting for ts_ls)
				config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
				-- config.capabilities = require("blink-cmp").get_lsp_capabilities(config.capabilities, true)

				-- disable semantic highlighting on init
				-- server.on_init = function(client, _)
				-- 	if client.supports_method("textDocument/semanticTokens") then
				-- 		client.server_capabilities.semanticTokensProvider = nil
				-- 	end
				-- end

				-- finally setup the lsp with all the defined configuration (general & custom)
				lsp_config[server].setup(config)
			end
		end,
	},
}
