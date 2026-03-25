return function()
	-----------------------------------------------------------
	-- Treesitter configuration file
	----------------------------------------------------------
	-- Plugin: nvim-treesitter
	-- url: https://github.com/nvim-treesitter/nvim-treesitter
	local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end

	-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
	nvim_treesitter.setup({
		-- A list of parser names, or "all"
		ensure_installed = {
			"markdown",
			"markdown_inline",
			"bash",
			"c",
			"css",
			"html",
			"javascript",
			"json",
			"lua",
			"python",
			"rust",
			"typescript",
			"vim",
			"go",
			"yaml",
			"sql",
			"solidity",
		},
		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		refactor = {
			highlight_definitions = {
				enable = true,
			},
		},
		highlight = {
			-- `false` will disable the whole extension
			enable = true,
			-- Disable treesitter highlight for big files (safety net for core/bigfile.lua)
			disable = function(_, buf)
				if vim.b[buf].bigfile then
					return true
				end
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
				return ok and stats and stats.size > 1.5 * 1024 * 1024
			end,
			additional_vim_regex_highlighting = false,
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_files_lines = nil,
		},
	})
end
