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
if not vim.uv.fs_stat(lazypath) then
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
			event = "VeryLazy",
			config = function()
				require("gitlinker").setup()
			end,
		},
		{ "onsails/lspkind.nvim" },
		{ "mfussenegger/nvim-jdtls", ft = { "java" } },
		{
			"barrett-ruth/live-server.nvim",
			build = "yarn global add live-server",
			cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
			config = true,
		},
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				{
					"rcarriga/nvim-dap-ui",
					dependencies = { "nvim-neotest/nvim-nio" },
				},
			},
			keys = {
				{
					"<leader>b",
					function()
						require("dap").toggle_breakpoint()
					end,
					desc = "DAP toggle breakpoint",
				},
				{
					"<leader>c",
					function()
						require("dap").continue()
					end,
					desc = "DAP continue",
				},
				{
					"<leader>o",
					function()
						require("dap").step_over()
					end,
					desc = "DAP step over",
				},
				{
					"<leader>s",
					function()
						require("dap").step_into()
					end,
					desc = "DAP step into",
				},
				{
					"<leader>r",
					function()
						require("dap").repl.open()
					end,
					desc = "DAP repl open",
				},
				{
					"<leader>u",
					function()
						require("dapui").toggle()
					end,
					desc = "DAP UI toggle",
				},
			},
			config = function()
				require("plugins/nvim-dap")()
			end,
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			config = function()
				require("plugins/which-key")()
			end,
		}, -- project file navigation
		{
			"ThePrimeagen/harpoon",
			dependencies = { "nvim-lua/plenary.nvim" },
			keys = {
				{
					"<leader>ha",
					function()
						require("harpoon.mark").add_file()
					end,
					desc = "Add file to harpoon",
				},
				{
					"<leader>hl",
					function()
						require("harpoon.ui").toggle_quick_menu()
					end,
					desc = "Toggle quick menu",
				},
				{
					"<leader>hr",
					function()
						require("harpoon.mark").rm_file()
					end,
					desc = "Remove file from harpoon",
				},
				{
					"<A-1>",
					function()
						require("harpoon.ui").nav_file(1)
					end,
					desc = "Harpoon file 1",
				},
				{
					"<A-2>",
					function()
						require("harpoon.ui").nav_file(2)
					end,
					desc = "Harpoon file 2",
				},
				{
					"<A-3>",
					function()
						require("harpoon.ui").nav_file(3)
					end,
					desc = "Harpoon file 3",
				},
				{
					"<A-4>",
					function()
						require("harpoon.ui").nav_file(4)
					end,
					desc = "Harpoon file 4",
				},
			},
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
			cmd = { "ToggleTerm", "TermExec" },
			keys = { { "<c-\\>", desc = "Toggle terminal" } },
			config = function()
				require("plugins/toggleterm")()
			end,
		},
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			event = { "BufReadPost", "BufNewFile" },
			cmd = { "TodoQuickFix", "TodoLocList", "TodoTelescope", "TodoTrouble" },
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
			event = "LspAttach",
			dependencies = { "kevinhwang91/promise-async" },
			config = function()
				require("ufo").setup({
					close_fold_kinds_for_ft = {
						java = { "imports" },
					},
					provider_selector = function(bufnr, filetype, buftype)
						return { "lsp", "indent" }
					end,
				})
			end,
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
			config = function()
				require("lsp/go")
			end,
		}, -- rust
		{ "https://gitlab.com/yorickpeterse/nvim-dd.git" },
		{ "rust-lang/rust.vim", ft = { "rust" } },
		{
			"mrcjkb/rustaceanvim",
			version = "^5",
			ft = { "rust" },
		}, -- common stuff
		{ "stevearc/dressing.nvim", event = "VeryLazy" },
		{ "godlygeek/tabular", cmd = { "Tabularize", "GTabularize" } },
		{
			"petertriho/nvim-scrollbar",
			event = { "BufReadPost", "BufNewFile" },
			config = function()
				require("scrollbar").setup({
					excluded_buftypes = { "terminal", "nofile" },
				})
			end,
		},
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			dependencies = {
				"MunifTanjim/nui.nvim",
				"rcarriga/nvim-notify",
			},
			config = function()
				local severity =
					{ vim.log.levels.ERROR, vim.log.levels.WARN, vim.log.levels.INFO, vim.log.levels.DEBUG }
				vim.lsp.handlers["window/showMessage"] = function(err, result, _ctx, _config)
					if err then
						local err_msg = type(err) == "table" and err.message or tostring(err)
						vim.notify("LSP window/showMessage error: " .. err_msg, vim.log.levels.ERROR)
						return
					end
					if not result or type(result) ~= "table" then
						vim.notify("LSP: Invalid window/showMessage payload (missing result)", vim.log.levels.WARN)
						return
					end
					if not result.message then
						vim.notify("LSP: Invalid window/showMessage payload (missing message)", vim.log.levels.WARN)
						return
					end
					if not result.type or type(result.type) ~= "number" then
						vim.notify(
							"LSP: Invalid window/showMessage payload (missing or invalid type)",
							vim.log.levels.WARN
						)
						return
					end
					local msg_type = math.floor(math.max(1, math.min(4, result.type)))
					vim.notify(result.message, severity[msg_type])
				end

				require("noice").setup({
					lsp = {
						override = {
							["vim.lsp.util.convert_input_to_markdown_lines"] = true,
							["vim.lsp.util.stylize_markdown"] = true,
							["cmp.entry.get_documentation"] = true,
						},
					},
					presets = {
						bottom_search = true,
						command_palette = true,
						long_message_to_split = true,
						inc_rename = false,
						lsp_doc_border = false,
					},
					routes = {
						{
							filter = { find = "getting file for InlayHint" },
							opts = { skip = true },
						},
						{
							view = "notify",
							filter = { event = "msg_showmode", find = "recording" },
						},
						{
							filter = { kind = "echo", ["not"] = { find = "Exception" } },
							opts = { skip = true },
						},
					},
				})
			end,
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "markdown" },
			cmd = { "RenderMarkdown" },
			keys = {
				{ "<leader>mp", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown Preview" },
				{ "<leader>mv", "<cmd>RenderMarkdown preview<CR>", desc = "Open Markdown Side Preview" },
			},
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
				"nvim-tree/nvim-web-devicons",
			},
			opts = {
				enabled = true,
				file_types = { "markdown" },
				render_modes = { "n", "c", "t" },
				heading = {
					sign = false,
					width = "block",
					left_pad = 1,
				},
				code = {
					sign = false,
					width = "block",
				},
			},
		},
		{
			"iamcco/markdown-preview.nvim",
			ft = { "markdown" },
			cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
			build = "cd app && npx --yes yarn install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
				vim.g.mkdp_theme = "dark"
			end,
			keys = {
				{ "<leader>mb", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Browser Markdown Preview" },
			},
		}, -- colorize
		{
			"NvChad/nvim-colorizer.lua",
			event = { "BufReadPost", "BufNewFile" },
			config = function()
				require("colorizer").setup({
					"css",
					"scss",
					"sass",
					"less",
					"stylus",
					"html",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
				}, {
					css = true,
					mode = "background",
				})
			end,
		},
		{
			"hiphish/rainbow-delimiters.nvim", -- Powered by Tree-sitter
			submodules = false,
			event = { "BufReadPost", "BufNewFile" },
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
			event = "VeryLazy",
			dependencies = { "nvim-tree/nvim-web-devicons", "linrongbin16/lsp-progress.nvim" },
			config = function()
				require("core/statusline")()
			end,
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
			event = "VimEnter",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("plugins/alpha-nvim")()
			end,
		}, -- Git
		{
			"rhysd/git-messenger.vim",
			cmd = { "GitMessenger" },
			keys = { { "<leader>gm", "<Plug>(git-messenger)", desc = "Git messenger" } },
		},
		{
			"lewis6991/gitsigns.nvim",
			event = { "BufReadPost", "BufNewFile" },
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("plugins/git")()
			end,
		}, -- meta jump (moved to Codeberg: andyg/leap.nvim)
		{
			name = "leap.nvim",
			url = "https://codeberg.org/andyg/leap.nvim",
			dependencies = { "tpope/vim-repeat" },
			keys = {
				{ "s", "<Plug>(leap-forward)", mode = { "n", "x", "o" }, desc = "Leap forward" },
				{ "S", "<Plug>(leap-backward)", mode = { "n", "x", "o" }, desc = "Leap backward" },
				{ "gs", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from window" },
			},
		},
		{ "RRethy/vim-illuminate", event = "LspAttach" },
		{
			"Yggdroot/LeaderF",
			build = ":LeaderfInstallCExtension",
			-- Add further Leaderf* commands here if new mappings require them.
			cmd = { "Leaderf", "LeaderfFile" },
			init = function()
				vim.cmd([[
					let g:Lf_PreviewInPopup = 0
					let g:Lf_PreviewResult = {'Rg': 1 }
					let g:Lf_UseCache = 0
					let g:Lf_UseMemoryCache = 0
					let g:Lf_UseVersionControlTool = 0
					let g:Lf_CommandMap = {'<C-K>': ['<C-P>'], '<C-J>': ['<C-N>']}
				]])
			end,
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
		-- Keep vim-rooter eager: its own VimEnter/BufEnter hooks need to exist
		-- before the first real buffer if we want initial-buffer cwd detection.
		{
			"airblade/vim-rooter",
			lazy = false,
			init = function()
				vim.g.rooter_patterns = { ".git", "Cargo.toml", "go.mod", "Pipfile", "package.json" }
			end,
		},
		-- Treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			event = { "BufReadPost", "BufNewFile" },
			build = ":TSUpdate",
			config = function()
				require("plugins/nvim-treesitter")()
			end,
		}, -- Indent line
		{
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufReadPost", "BufNewFile" },
			main = "ibl",
			config = function()
				require("plugins/indent-blankline")()
			end,
		}, -- Tag viewer
		-- Autopair
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		}, -- LSP
		-- mason.nvim: command-lazy only; ensure_installed lives in mason-lspconfig.
		{
			"mason-org/mason.nvim",
			cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
			opts = {},
		},
		-- mason-lspconfig: ensure_installed uses lspconfig server names.
		-- Loaded alongside mason.nvim on demand, and also shortly after interactive
		-- startup so ensure_installed still runs on fresh setups without blocking boot.
		-- The delayed load is safe to race with :Mason command-triggered loading.
		-- On a fresh install, opening :Mason manually is still the fastest path if
		-- a file is opened before this deferred ensure_installed load fires.
		{
			"mason-org/mason-lspconfig.nvim",
			cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
			dependencies = { "mason-org/mason.nvim" },
			init = function()
				vim.api.nvim_create_autocmd("VimEnter", {
					once = true,
					callback = function()
						local non_interactive_flags = {
							"--headless",
							"--embed",
							"-e",
							"-E",
							"-es",
							"-Es",
						}
						for _, flag in ipairs(non_interactive_flags) do
							if vim.tbl_contains(vim.v.argv, flag) then
								return
							end
						end

						if #vim.api.nvim_list_uis() == 0 then
							return
						end

						vim.defer_fn(function()
							require("lazy").load({
								plugins = { "mason-org/mason-lspconfig.nvim" },
							})
						end, 100)
					end,
				})
			end,
			config = function()
				require("mason-lspconfig").setup({
					ensure_installed = { "lua_ls", "tinymist", "terraformls", "marksman" },
					automatic_setup = false,
					automatic_enable = false,
				})
			end,
		},
		-- nvim-lspconfig: explicitly buffer-lazy so lsp/lspconfig.lua loads on
		-- the first real file open, not as a side effect of another plugin.
		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("lsp/lspconfig")
			end,
		},
		{
			"glepnir/lspsaga.nvim",
			event = "LspAttach",
			keys = { { "<C-l>", "<cmd>Lspsaga outline<CR>", desc = "Toggle Lspsaga outline" } },
			-- Explicit dependency ensures nvim-lspconfig (and lsp/lspconfig.lua)
			-- is initialised before lspsaga sets up its UI.
			dependencies = {
				{ "nvim-tree/nvim-web-devicons" },
				{ "nvim-treesitter/nvim-treesitter" },
				{ "neovim/nvim-lspconfig" },
			},
			config = function()
				require("lspsaga").setup({
					outline = {
						auto_preview = false,
					},
					symbol_in_winbar = {
						color_mode = false,
					},
				})
			end,
		}, -- tree
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			dependencies = { "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
			cmd = { "Neotree" },
			keys = { { "<C-t>", ":Neotree toggle reveal=true<CR>", desc = "Toggle file tree" } },
			init = function()
				vim.g.neo_tree_remove_legacy_commands = 1
				-- Defer directory launches until VimEnter so plain startup stays
				-- cold. Loading the plugin is enough here: neo-tree.setup() will
				-- hijack the current directory buffer exactly once.
				if vim.fn.argc() == 1 then
					local arg = vim.fn.argv(0)
					local stat = vim.uv.fs_stat(arg)
					if stat and stat.type == "directory" then
						vim.api.nvim_create_autocmd("VimEnter", {
							once = true,
							callback = function()
								if #vim.api.nvim_list_uis() == 0 then
									return
								end

								require("lazy").load({ plugins = { "neo-tree.nvim" } })
							end,
						})
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
				{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"saadparwaiz1/cmp_luasnip",
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
