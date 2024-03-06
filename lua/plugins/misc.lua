require("symbols-outline").setup({
	autofold_depth = 1,
})
require("scrollbar").setup({
	excluded_buftypes = { "terminal", "nofile" },
})
require("leap").add_default_mappings()
require("colorizer").setup()
require("ufo").setup({
	close_fold_kinds = { "imports" },
	provider_selector = function(bufnr, filetype, buftype)
		return { "lsp", "indent" }
	end,
})

-- remove leap's forward till mapping
vim.keymap.del({ "o", "x" }, "x")

vim.g.rooter_patterns = { ".git", "Cargo.toml", "go.mod", "Pipfile", "package.json" }
