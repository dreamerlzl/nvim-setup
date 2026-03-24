-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------
-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim
-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Start setup
lazy.setup({
	spec = {
		{
			"MysticalDevil/inlay-hints.nvim",
			event = "LspAttach",
			dependencies = { "neovim/nvim-lspconfig" },
			config = function()
				require("inlay-hints").setup()
			end,
		},
		{
			"linrongbin16/gitlinker.nvim",
			config = function()
				require("gitlinker").setup()
			end,
		},
		{ "onsails/lspkind.nvim" },
		{ "mfussenegger/nvim-jdtls" },
		{
			"barrett-ruth/live-server.nvim",
			build = "yarn global add live-server",
			config = true,
		},
		{ "mfussenegger/nvim-dap" },
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"mfussenegger/nvim-dap",
				"nvim-neotest/nvim-nio",
			},
		},
		{ "folke/which-key.nvim" }, -- project file navigation
		{
			"ThePrimeagen/harpoon",
			dependencies = { "nvim-lua/plenary.nvim" },
		}, -- formatting
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			opts = {},
			keys = {
				{
					"<leader>m",
					function()
						require("conform").format({
							async = true,
						})
					end,
					mode = "",
					desc = "Format buffer",
				},
			},
			-- This will provide type hinting with LuaLS
			---@module "conform"
			---@type conform.setupOpts
			opts = {
				-- Define your formatters
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff_organize_imports", "ruff_format", "ruff_fix" },
					terraform = { "terraform_fmt" },
					hcl = { "terraform_fmt" },
				},
				-- Set default options
				default_format_opts = {
					lsp_format = "fallback",
				},
				-- Set up format-on-save
				format_on_save = {
					timeout_ms = 500,
				},
			},
		},
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			config = true,
		},
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("todo-comments").setup({
					colors = {
						info = { "#b57614" },
					},
				})
			end,
		}, -- folding
		{
			"kevinhwang91/nvim-ufo",
			event = "BufRead",
			dependencies = { "kevinhwang91/promise-async" },
		}, -- go
		{
			"ray-x/go.nvim",
			dependencies = { -- optional packages
				"ray-x/guihua.lua",
				"neovim/nvim-lspconfig",
				"nvim-treesitter/nvim-treesitter",
			},
			event = { "CmdlineEnter" },
			ft = { "go", "gomod" },
		}, -- rust
		{ "https://gitlab.com/yorickpeterse/nvim-dd.git" },
		{ "rust-lang/rust.vim" },
		{
			"mrcjkb/rustaceanvim",
			version = "^5",
			ft = { "rust" },
		}, -- common stuff
		{ "stevearc/dressing.nvim" },
		{ "godlygeek/tabular" },
		{ "petertriho/nvim-scrollbar" },
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = {
				-- add any options here
			},
			dependencies = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim", -- OPTIONAL:
				--   `nvim-notify` is only needed, if you want to use the notification view.
				--   If not available, we use `mini` as the fallback
				"rcarriga/nvim-notify",
			},
		},
		{ "rcarriga/nvim-notify" }, -- colorize
		{ "NvChad/nvim-colorizer.lua" },
		{
			"hiphish/rainbow-delimiters.nvim", -- Powered by Tree-sitter
			submodules = false,
			opts = {
				strategy = {
					[""] = "rainbow-delimiters.strategy.global",
					vim = "rainbow-delimiters.strategy.local",
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			},
			main = "rainbow-delimiters.setup", -- Required. Defaults to the repository name if not set.
		}, -- statusline
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons", "linrongbin16/lsp-progress.nvim" },
		},
		{
			"linrongbin16/lsp-progress.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("lsp-progress").setup()
			end,
		}, -- Icons
		{
			"nvim-tree/nvim-web-devicons",
			lazy = true,
		}, -- Dashboard (start screen)
		{
			"goolord/alpha-nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		}, -- Git
		{ "rhysd/git-messenger.vim" },
		{
			"lewis6991/gitsigns.nvim",
			lazy = true,
			dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		}, -- meta jump (moved to Codeberg: andyg/leap.nvim)
		{
			name = "leap.nvim",
			url = "https://codeberg.org/andyg/leap.nvim",
			dependencies = { "tpope/vim-repeat" },
		},
		{ "RRethy/vim-illuminate" },
		{
			"Yggdroot/LeaderF",
			build = ":LeaderfInstallCExtension",
		},
		-- {
		-- 	"dmtrKovalenko/fff.nvim",
		-- 	build = function()
		-- 		-- this will download prebuild binary or try to use existing rustup toolchain to build from source
		-- 		-- (if you are using lazy you can use gb for rebuilding a plugin if needed)
		-- 		require("fff.download").download_or_build_binary()
		-- 	end,
		-- 	-- if you are using nixos
		-- 	-- build = "nix run .#release",
		-- 	opts = { -- (optional)
		-- 		debug = {
		-- 			enabled = true, -- we expect your collaboration at least during the beta
		-- 			show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
		-- 		},
		-- 	},
		-- 	-- No need to lazy-load with lazy.nvim.
		-- 	-- This plugin initializes itself lazily.
		-- 	lazy = false,
		-- 	keys = {
		-- 		{
		-- 			"<leader>f", -- try it if you didn't it is a banger keybinding for a picker
		-- 			function()
		-- 				require("fff").find_files()
		-- 			end,
		-- 			desc = "FFFind files",
		-- 		},
		-- 		{
		-- 			"<leader>j",
		-- 			function()
		-- 				require("fff").live_grep()
		-- 			end,
		-- 			desc = "LiFFFe grep",
		-- 		},
		-- 		{
		-- 			"<leader>z",
		-- 			function()
		-- 				require("fff").live_grep({
		-- 					grep = {
		-- 						modes = { "fuzzy", "plain" },
		-- 					},
		-- 				})
		-- 			end,
		-- 			desc = "Live fffuzy grep",
		-- 		},
		-- 		{
		-- 			"<leader>c",
		-- 			function()
		-- 				require("fff").live_grep({ query = vim.fn.expand("<cword>") })
		-- 			end,
		-- 			desc = "Search current word",
		-- 		},
		-- 	},
		-- },
		{ "airblade/vim-rooter" },
		{
			"stevearc/aerial.nvim",
			opts = {},
			-- Optional dependencies
			dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		}, -- Treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		}, -- Indent line
		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			opts = {},
		}, -- Tag viewer
		-- Autopair
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		}, -- LSP
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {},
			dependencies = {
				{
					"mason-org/mason.nvim",
					opts = {
						ensure_installed = { "tinymist", "terraform-ls" },
					},
				},
				"neovim/nvim-lspconfig",
			},
			config = function()
				require("mason-lspconfig").setup({
					automatic_setup = false,
					automatic_enable = false,
					handlers = nil,
				})
			end,
		},
		{ "neovim/nvim-lspconfig" },
		{
			"glepnir/lspsaga.nvim",
			event = "BufRead",
			config = function()
				-- Defer the (heavier) LSP server configuration until we actually
				-- open a buffer.
				require("lsp/lspconfig")
				require("lspsaga").setup({
					symbol_in_winbar = {
						color_mode = false,
					},
				})
			end,
			dependencies = { { "nvim-tree/nvim-web-devicons" }, { "nvim-treesitter/nvim-treesitter" } },
		}, -- tree
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			dependencies = { "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
			keys = { { "<C-t>", ":Neotree toggle reveal=true<CR>" } },
			init = function()
				vim.g.neo_tree_remove_legacy_commands = 1
				if vim.fn.argc() == 1 then
					local stat = vim.loop.fs_stat(vim.fn.argv(0))
					if stat and stat.type == "directory" then
						require("neo-tree")
					end
				end
			end,
			opts = {
				-- make lazy manage your config
				follow_current_file = true,
				filesystem = {
					hijack_netrw_behavior = "open_current",
					group_empty_dirs = true,
				},
			},
		}, -- Autocomplete
		{
			"hrsh7th/nvim-cmp",
			-- load cmp on InsertEnter
			event = "InsertEnter",
			-- these dependencies will only be loaded when cmp loads
			-- dependencies are always lazy-loaded unless specified otherwise
			dependencies = {
				"L3MON4D3/LuaSnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-vsnip",
				"hrsh7th/vim-vsnip",
				"rafamadriz/friendly-snippets",
			},
			config = function()
				require("core/cmp")
			end,
		},
	},
}, {
	install = {
		colorscheme = { "shine" },
	},
})
