-- char to  trigger for snippets
local trigger_text = ";"

-- Trying auto complete with blink.cmp (which seem better than nvim-cmp)
return {
	"saghen/blink.cmp",
	event = { "VimEnter" },
	enabled = true,

	-- use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	build = "cargo build --release",

	-- provide plenty of predefined snippets for various languages
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
	},

	opts = {

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		-- completion sources
		sources = {

			default = { "lsp", "snippets", "lazydev", "buffer", "path" },

			-- define custom config for source providers
			providers = {

				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},

				lsp = {
					name = "LSP",
					enabled = true,
					module = "blink.cmp.sources.lsp",

					-- https://cmp.saghen.dev/recipes.html#show-on-newline-tab-and-space
					override = {
						get_trigger_characters = function(self)
							local trigger_characters = self:get_trigger_characters()
							vim.list_extend(trigger_characters, { "\n", "\t", " " })
							return trigger_characters
						end,
					},
					score_offset = 95,
				},

				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 25,

					-- fallbacks to show if there are no path completion
					fallbacks = { "snippets", "buffer" },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},

				buffer = {
					name = "Buffer",
					max_items = 3,
					module = "blink.cmp.sources.buffer",
					min_keyword_length = 3,
					score_offset = 15, -- the higher the number, the higher the priority
				},

				snippets = {
					name = "snippets",
					max_items = 8,
					min_keyword_length = 2,
					module = "blink.cmp.sources.snippets",
					score_offset = 85,

					-- Only show snippets if trigger_text is pressed
					should_show_items = function()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
						return before_cursor:match(trigger_text .. "%w*$") ~= nil
					end,

					-- After accepting the completion, delete the trigger_text characters from the final inserted text
					transform_items = function(_, items)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
						local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
						if trigger_pos then
							for _, item in ipairs(items) do
								item.textEdit = {
									newText = item.insertText or item.label,
									range = {
										start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
										["end"] = { line = vim.fn.line(".") - 1, character = col },
									},
								}
							end
						end

						-- reload luasnip after transformation to avoid crazy behaviour
						vim.schedule(function()
							require("blink.cmp").reload("snippets")
						end)
						return items
					end,
				},
			},
		},

		-- configure the behaviour of the completion
		completion = {

			-- fuzzy match on the text before *and* after the cursor
			keyword = { range = "prefix" },

			-- enable auto pair
			accept = { auto_brackets = { enabled = true } },

			trigger = {

				-- prefetch the completion items when entering insert mode
				prefetch_on_insert = true,

				-- Shows after typing a keyword, typically an alphanumeric characters
				show_on_keyword = true,

				-- Shows after typing a trigger character, lua (.)
				show_on_trigger_character = true,

				-- will not show the completion window automatically when in a snippet
				-- coz we don't want completion inside snippet as we want to do snippet forward/ackward
				show_in_snippet = false,
			},

			list = {
				max_items = 200,
				selection = {

					-- first item in completion is automatically selected
					preselect = true,

					-- whether the preselected items is automatically inserted, disable for ghost text
					auto_insert = false,
				},
			},

			menu = {

				draw = {

					-- treesitter to highlight the label text for the given list of sources
					treesitter = { "lsp" },

					-- nvim-cmp style menu
					-- columns = {
					-- 	{ "label", "label_description" },
					-- 	{ "kind_icon", "kind" },
					-- },
				},

				border = "single",

				-- auto show completion (files and cmd)
				auto_show = true,
			},

			-- Show documentation when selecting a completion item
			-- https://cmp.saghen.dev/configuration/completion.html#documentation
			documentation = {
				window = { border = "single" },
				auto_show = true,
				auto_show_delay_ms = 300,
				treesitter_highlighting = true,
			},

			-- Display a preview of the selected item on the current line
			-- https://cmp.saghen.dev/configuration/completion.html#ghost-text
			ghost_text = { enabled = true },
		},

		--  luasnip presets (use luasnip modue for expand, jump, ...)
		--  https://github.com/Saghen/blink.cmp/blob/main/lua/blink/cmp/config/snippets.lua#L23
		--  https://cmp.saghen.dev/configuration/snippets.html
		snippets = { preset = "luasnip" },

		signature = {
			enabled = true, -- function signature
			window = { border = "single" },
		},

		fuzzy = {
			-- Disabling this matches the behavior of fzf
			-- use_typo_resistance = true,
			-- Frecency tracks the most recently/frequently used items and boosts the score of the item
			-- frecency = false,
			-- Proximity bonus boosts the score of items matching nearby words
			use_proximity = true,
		},

		keymap = {
			-- Fully custom keymaps for autocompletion (without any preset)
			-- https://cmp.saghen.dev/configuration/keymap.html

			-- for list of commands, each command would return true/false
			-- if a cmd return false/nil, next cmd in the list will run.

			preset = "none",

			-- shows the completion menu (probably not needed as auto_show is on),
			-- or shows the documentation,
			-- or hides the documentation
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

			-- hide the cmpletion menu
			["<C-e>"] = { "hide" },

			-- revert auto_insert and hide the completion menu
			["<C-c>"] = { "cancel" },

			-- up/down
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			-- Tab complete
			-- or move to the next/previous placholder in the snippet
			-- or act as a regular tab key
			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			-- scroll documentation up/down by 4 lines
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},
	},
	opts_extend = { "sources.default" },
}

-- Using nvim-cmp
-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	event = "InsertEnter",
-- 	dependencies = {
-- 		{
-- 			"L3MON4D3/LuaSnip",
-- 			build = (function()
-- 				-- Build Step is needed for regex support in snippets.
-- 				-- This step is not supported in many windows environments.
-- 				-- Remove the below condition to re-enable on windows.
-- 				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
-- 					return
-- 				end
-- 				return "make install_jsregexp"
-- 			end)(),
-- 			dependencies = {
-- 				{
-- 					"rafamadriz/friendly-snippets",
-- 					config = function()
-- 						require("luasnip.loaders.from_vscode").lazy_load()
-- 					end,
-- 				},
-- 			},
-- 		},
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-nvim-lsp-signature-help",
-- 	},
-- 	config = function()
-- 		local cmp = require("cmp")
--
-- 		-- intialize luasnip
-- 		local luasnip = require("luasnip")
-- 		luasnip.config.setup({})
--
-- 		-- auto cmp setup
-- 		cmp.setup({
-- 			sources = {
-- 				{ name = "nvim_lsp" },
-- 				{ name = "nvim_lsp_signature_help" },
-- 				{ name = "luasnip" },
-- 				{ name = "lazydev", group_index = 0 },
-- 				{ name = "path" },
-- 			},
-- 			snippet = { -- :help vim.snippet
-- 				expand = function(args)
-- 					require("luasnip").lsp_expand(args.body)
-- 				end,
-- 			},
-- 			mapping = cmp.mapping.preset.insert({
--
-- 				-- Select the [n]ext item
-- 				["<C-n>"] = cmp.mapping.select_next_item(),
--
-- 				-- Select the [p]revious item
-- 				["<C-p>"] = cmp.mapping.select_prev_item(),
--
-- 				-- Scroll the documentation window [b]ack / [f]orward
-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
--
-- 				-- Accept completion
-- 				["<CR>"] = cmp.mapping.confirm({ select = true }),
--
-- 				-- move to the right of the expansion
-- 				["<C-l>"] = cmp.mapping(function()
-- 					if luasnip.expand_or_locally_jumpable() then
-- 						luasnip.expand_or_jump()
-- 					end
-- 				end, { "i", "s" }),
--
-- 				-- move backwards
-- 				["<C-h>"] = cmp.mapping(function()
-- 					if luasnip.locally_jumpable(-1) then
-- 						luasnip.jump(-1)
-- 					end
-- 				end, { "i", "s" }),
--
-- 				-- if completion menu visible, navigate to next item
-- 				-- if cursor is on snippet trigger, expand item
-- 				-- if cursor can jump to snippet placholder, moves item
-- 				-- if curso is middle of word, trigger completion menu
-- 				-- else, act as a regular tab key
-- 				["<Tab>"] = cmp.mapping(function(fallback)
-- 					local luasnip = require("luasnip")
-- 					local col = vim.fn.col(".") - 1
--
-- 					if cmp.visible() then
-- 						cmp.select_next_item({ behavior = "select" })
-- 					elseif luasnip.expand_or_locally_jumpable() then
-- 						luasnip.expand_or_jump()
-- 					elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
-- 						fallback()
-- 					else
-- 						cmp.complete()
-- 					end
-- 				end, { "i", "s" }),
--
-- 				["<S-Tab>"] = cmp.mapping(function(fallback)
-- 					local luasnip = require("luasnip")
--
-- 					if cmp.visible() then
-- 						cmp.select_prev_item({ behavior = "select" })
-- 					elseif luasnip.locally_jumpable(-1) then
-- 						luasnip.jump(-1)
-- 					else
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
-- 			}),
--
-- 			preselect = "item",
-- 			completion = {
-- 				-- autocomplete = true,
-- 				completeopt = "menu,menuone,noinsert",
-- 			},
-- 			window = {
-- 				completion = cmp.config.window.bordered(),
-- 				documentation = cmp.config.window.bordered(),
-- 			},
-- 		})
-- 	end,
-- }
