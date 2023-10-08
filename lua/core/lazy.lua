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
			"Exafunction/codeium.vim",
			event = "BufEnter",
			config = function()
				vim.keymap.set("i", "<C-g>", function()
					return vim.fn["codeium#Accept"]()
				end, { expr = true })
			end,
		},
		-- debug
		{
			"mfussenegger/nvim-dap",
		},
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "mfussenegger/nvim-dap" },
		},

		{
			"folke/which-key.nvim",
		},
		-- project file navigation
		{
			"ThePrimeagen/harpoon",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		-- formatting
		{
			"jose-elias-alvarez/null-ls.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{ "akinsho/toggleterm.nvim", version = "*", config = true },
		--{
		--	"jackMort/ChatGPT.nvim",
		--	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		--	config = function()
		--		require("chatgpt").setup({
		--			keymaps = {
		--				submit = "<C-s>",
		--			},
		--			openai_params = {
		--				model = "gpt-3.5-turbo",
		--			},
		--		})
		--	end,
		--},
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("todo-comments").setup({})
			end,
		},
		-- folding
		{
			"kevinhwang91/nvim-ufo",
			dependencies = { "kevinhwang91/promise-async" },
		},
		-- go
		{
			"ray-x/go.nvim",
			dependencies = { -- optional packages
				"ray-x/guihua.lua",
				"neovim/nvim-lspconfig",
				"nvim-treesitter/nvim-treesitter",
			},
			event = { "CmdlineEnter" },
			ft = { "go", "gomod" },
		},

		-- rust
		{ "https://gitlab.com/yorickpeterse/nvim-dd.git" },
		{ "rust-lang/rust.vim" },
		{ "simrat39/rust-tools.nvim" },

		-- common stuff
		{ "stevearc/dressing.nvim" },
		{ "godlygeek/tabular" },
		{ "petertriho/nvim-scrollbar" },
		{
			"folke/noice.nvim",
			dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		},
		{ "rcarriga/nvim-notify" },

		-- colorize
		{ "NvChad/nvim-colorizer.lua" },
		{ "mrjones2014/nvim-ts-rainbow" },

		-- statusline
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
		},

		-- Icons
		{
			"nvim-tree/nvim-web-devicons",
			lazy = true,
		},

		-- Dashboard (start screen)
		{
			"goolord/alpha-nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},

		-- Git
		{ "rhysd/git-messenger.vim" },
		{
			"lewis6991/gitsigns.nvim",
			lazy = true,
			dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		},

		-- meta jump
		{
			"ggandor/leap.nvim",
			dependencies = { "tpope/vim-repeat" },
		},
		{ "RRethy/vim-illuminate" },
		{
			"Yggdroot/LeaderF",
			build = ":LeaderfInstallCExtension",
		},
		{ "airblade/vim-rooter" },
		{ "simrat39/symbols-outline.nvim" }, -- File explorer

		-- Treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		},

		-- Indent line
		{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- Tag viewer

		-- Autopair
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		},

		-- LSP
		{
			"williamboman/mason-lspconfig.nvim",
			dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
		},
		{ "neovim/nvim-lspconfig" },
		{
			"glepnir/lspsaga.nvim",
			event = "BufRead",
			config = function()
				require("lspsaga").setup({})
			end,
			dependencies = { { "nvim-tree/nvim-web-devicons" }, { "nvim-treesitter/nvim-treesitter" } },
		},

		-- tree
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
				"nvim-lua/plenary.nvim",
			},
			keys = {
				{ "<C-t>", ":Neotree toggle reveal=true<CR>" },
			},
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
				},
			},
		},
		-- Autocomplete
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
			},
		},
	},
}, {
	install = {
		colorscheme = { "shine" },
	},
})
