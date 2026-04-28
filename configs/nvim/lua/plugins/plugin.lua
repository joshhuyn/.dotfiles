return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"mason-org/mason.nvim",
		opts = {}
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/vim-vsnip" },

	{ "neovim/nvim-lspconfig",
		config = function()
			-- Set up lspconfig.
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			local configuredLsps = {
				"lua_ls",
				"terraformls",
				"ts_ls"
			}

			for _, configuredLsp in ipairs(configuredLsps) do

				vim.lsp.config(configuredLsp, {
					capabilities = capabilities
				})

				vim.lsp.enable(configuredLsp)
			end
		end,
	}
}

