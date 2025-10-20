-- this is basically a portal package manager, it install and manages packages for lsp, formatting, dap, etc..
-- and make it available within nvim (cmd). nvim call the package command and it would be availabe.
-- basically it installs the pkg and prepend it's path to rtp. thus nvim could access it.

Pkgs = {
	-- lua
	"stylua", -- formatting
	"lua-language-server", -- lsp

	-- python
	"basedpyright", -- lsp
	"python-lsp-server",
	"pyright",
	"jedi-language-server",
	"pylyzer",
	"ruff", -- formatter/linter
	"mypy", -- static type checker

	-- markdown
	"markdownlint", -- linter
}

return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	opts = {
		pip = {
			upgrade_pip = true,
		},
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	config = function(_, opts)
		-- initialize mason
		require("mason").setup(opts)

		-- install the packages which were not installed already
		-- since MasonInstall would use pkg:install async function for both single/multi args
		-- installation spped would be same compared to MasonInstall with multi pkg
		vim.api.nvim_create_user_command("MasonInstallAll", function()
			local registry = require("mason-registry")
			local missing = {}
			local to_uninstall = {}

			-- Install missing packages
			for _, pkg_name in ipairs(Pkgs) do
				local pkg = registry.get_package(pkg_name)
				if not pkg:is_installed() then
					table.insert(missing, pkg_name)
				end
			end

			-- Uninstall removed packages
			for _, installed_pkg in ipairs(registry.get_installed_packages()) do
				local is_removed = true
				for _, pkg_name in ipairs(Pkgs) do
					if installed_pkg.name == pkg_name then
						is_removed = false
						break
					end
				end
				if is_removed then
					table.insert(to_uninstall, installed_pkg.name)
				end
			end

			-- Install missing packages
			if #missing > 0 then
				vim.cmd("MasonInstall " .. table.concat(missing, " "))
			end

			-- Uninstall removed packages
			if #to_uninstall > 0 then
				vim.cmd("MasonUninstall " .. table.concat(to_uninstall, " "))
			end

			-- Notify if all packages are in sync
			if #missing == 0 and #to_uninstall == 0 then
				vim.notify("All packages are up-to-date!", vim.log.levels.INFO, { timeout = 4000 })
			end
		end, {})
	end,
}
