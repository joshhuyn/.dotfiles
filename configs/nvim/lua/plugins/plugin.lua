return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"mason-org/mason.nvim",
		opts = {}
	},
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    {
        "Mofiqul/dracula.nvim"
    },
    {
        "ellisonleao/gruvbox.nvim"
    },


    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '1.*',

        opts = {
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },

            appearance = {
            nerd_font_variant = 'hack'
            },

            completion = { documentation = { auto_show = false } },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        'saghen/blink.indent',
    },

    -- { "github/copilot.vim" },
	{
		'nvim-telescope/telescope.nvim', version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- optional but recommended
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		config = function()
			local builtin = require('telescope.builtin')

			vim.keymap.set('n', '<leader>fa', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		end
	},

	{ "neovim/nvim-lspconfig",
		config = function()
			-- Set up lspconfig.
			-- local capabilities = require('cmp_nvim_lsp').default_capabilities()


			local configuredLsps = {
				"lua_ls",
				"terraformls",
				"nxls",
				"ts_ls",
				"bashls",
                "docker_language_server",
                "pylsp",
                "helm_ls",
                "groovyls"
			}

			-- "java_language_server"
            local capabilities = require("blink.cmp").get_lsp_capabilities()

			for _, configuredLsp in ipairs(configuredLsps) do

				vim.lsp.config(configuredLsp, {
					capabilities = capabilities
				})

				vim.lsp.enable(configuredLsp)
			end
		end,
	},
	{
		'nvim-java/nvim-java',
		config = function()
			require('java').setup()
			vim.lsp.enable('jdtls')
		end,
	},
    {
      'akinsho/toggleterm.nvim',
      version = "*",
      config = true
    },
    {
      "NeogitOrg/neogit",
      lazy = true,
      dependencies = {
        -- Only one of these is needed.
        "sindrets/diffview.nvim",        -- optional
        "esmuellert/codediff.nvim",      -- optional

        -- For a custom log pager
        "m00qek/baleia.nvim",            -- optional

        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua",              -- optional
        "nvim-mini/mini.pick",           -- optional
        "folke/snacks.nvim",             -- optional
      },
      cmd = "Neogit",
      keys = {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
      }
    },
    {
        "lewis6991/gitsigns.nvim"
    }
}

