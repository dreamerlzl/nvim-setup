require("aerial").setup({
	-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	on_attach = function(bufnr)
		-- Jump forwards/backwards with '{' and '}'
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<C-l>", "<cmd>AerialToggle<CR>")

require("scrollbar").setup({
	excluded_buftypes = { "terminal", "nofile" },
})
require("leap").add_default_mappings()
require("colorizer").setup()
require("ufo").setup({
	close_fold_kinds_ft = { "imports" },
	provider_selector = function(bufnr, filetype, buftype)
		return { "lsp", "indent" }
	end,
})

-- remove leap's forward till mapping
vim.keymap.del({ "o", "x" }, "x")

vim.g.rooter_patterns = { ".git", "Cargo.toml", "go.mod", "Pipfile", "package.json" }

require("inlay-hints").setup({
	commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
	autocmd = { enable = true }, -- Enable the inlay hints on `LspAttach` event
})
