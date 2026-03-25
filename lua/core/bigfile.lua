-----------------------------------------------------------
-- Big file detection: disable expensive plugins for large buffers
-----------------------------------------------------------
-- Loaded early (before plugins) so the BufReadPre autocmd fires
-- before gitsigns, lspconfig, etc. attach to the buffer.

local bigfile_augroup = vim.api.nvim_create_augroup("BigFile", { clear = true })

-- Threshold: files larger than this are treated as "big"
local MAX_FILESIZE = 1.5 * 1024 * 1024 -- 1.5 MB
local MAX_LINES = 50000

vim.api.nvim_create_autocmd("BufReadPre", {
	group = bigfile_augroup,
	callback = function(args)
		local bufnr = args.buf
		local filename = args.match

		-- Check file size before the buffer is fully loaded
		local ok, stat = pcall(vim.uv.fs_stat, filename)
		if not ok or not stat then
			return
		end

		if stat.size < MAX_FILESIZE then
			return
		end

		-- Mark buffer so other plugins/autocmds can check
		vim.b[bufnr].bigfile = true

		-- Disable syntax and filetype-based highlighting
		vim.api.nvim_create_autocmd("BufReadPost", {
			buffer = bufnr,
			once = true,
			callback = function()
				vim.bo[bufnr].syntax = "off"
				vim.treesitter.stop(bufnr)
			end,
		})

		-- Disable buffer-local features
		vim.bo[bufnr].swapfile = false
		vim.bo[bufnr].undofile = false

		-- indent-blankline: buffer-level disable
		vim.b[bufnr].ibl_enabled = false

		-- rainbow-delimiters: buffer-level disable
		vim.g.rainbow_delimiters = vim.g.rainbow_delimiters or {}
		vim.b[bufnr].rainbow_delimiters = { strategy = { [""] = function() end } }

		-- vim-illuminate: disable for this buffer
		pcall(function()
			require("illuminate.engine").stop_buf(bufnr)
		end)

		-- Folding: switch to manual to avoid expensive computation
		vim.opt_local.foldmethod = "manual"
		vim.opt_local.foldenable = false

		vim.notify(
			"Big file detected (" .. math.floor(stat.size / 1024 / 1024) .. " MB) — heavy features disabled",
			vim.log.levels.WARN
		)
	end,
})

-- Post-load cleanup: detach plugins that require the buffer to be loaded
vim.api.nvim_create_autocmd("BufReadPost", {
	group = bigfile_augroup,
	callback = function(args)
		local bufnr = args.buf
		if not vim.b[bufnr].bigfile then
			return
		end

		-- gitsigns: detach from this buffer
		pcall(function()
			require("gitsigns").detach(bufnr)
		end)

		-- nvim-colorizer: detach from this buffer
		pcall(function()
			require("colorizer").detach_from_buffer(bufnr)
		end)

		-- nvim-ufo: disable for this buffer
		pcall(function()
			require("ufo").detach(bufnr)
		end)

		-- todo-comments: no per-buffer API, but it relies on treesitter
		-- which we already stopped above

		-- aerial: won't attach if treesitter is off

		-- nvim-scrollbar: relies on diagnostics/search marks, low impact
	end,
})
