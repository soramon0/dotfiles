local plugins = {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"gopls",
				"rust-analyzer",
				"pylyzer",
				"html-lsp",
				"eslint-lsp",
				"tailwindcss-language-server",
				"typescript-language-server",
				"prettierd",
				"stylua",
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		init = function()
			require("core.utils").load_mappings("dap")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		opts = function()
			return require("custom.configs.none-ls")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function()
			local opts = require("plugins.configs.treesitter")
			opts.ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"python",
				"tsx",
				"html",
				"css",
				"go",
				"rust",
			}
			return opts
		end,
	},
	-- Html Plugins
	{
		"windwp/nvim-ts-autotag", -- auto close tags
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"html",
			"gotmpl",
		},
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- Go PLugins
	{
		"leoluz/nvim-dap-go", -- debug go files
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
			require("core.utils").load_mappings("dap_go")
		end,
	},
	{
		"olexsmir/gopher.nvim", -- go nice of life tooling
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
			require("core.utils").load_mappings("gopher")
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},
	-- rust plugins
	{
		"rust-lang/rust.vim", -- official rust plugin
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"simrat39/rust-tools.nvim", -- debugging and other things
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		opts = function()
			return require("custom.configs.rust-tools")
		end,
		config = function(_, opts)
			require("rust-tools").setup(opts)
		end,
	},
	{
		"saecki/crates.nvim", -- rust crates niceties
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
		end,
	},
	{
		"hrsh7th/nvim-cmp", -- auto complete for rust crates
		opts = function()
			local M = require("plugins.configs.cmp")
			table.insert(M.sources, { name = "crates" })
			return M
		end,
	},
}

return plugins
