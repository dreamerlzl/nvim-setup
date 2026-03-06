local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name

local config = {
	cmd = {
		vim.fn.stdpath("data") .. "/mason/bin/jdtls",
		"--data",
		workspace_dir,
		"-Xmx4G",
		"-Xms100m",
		-- Use a faster Garbage Collector
		"-XX:+UseParallelGC",
		-- Disable memory mapping for zips to avoid some macOS-specific IO lag
		"-Dsun.zip.disableMemoryMapping=true",
	},
	init_options = {
		bundles = {}, -- Add your debug/test bundles here if you have them
		settings = {
			java = {
				autobuild = { enabled = false }, -- Stop building on every save/start
				configuration = {
					updateBuildConfiguration = "interactive",
					maven = {
						userSettings = vim.fn.expand("~/.m2/settings.xml"),
					},
				},
				-- Optional: improves performance by not indexing everything
				referencesCodeLens = { enabled = false },
				signatureHelp = { enabled = true },
			},
		},
	},
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}

config.settings = {
	java = {
		import = {
			gradle = {
				java = {
					home = vim.fn.expand("~/.sdkman/candidates/java/current"),
				},
			},
		},
		signatureHelp = { enabled = true },
		contentProvider = { preferred = "fernflower" },
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
			filteredTypes = {
				"com.sun.*",
				"io.micrometer.shaded.*",
				"java.awt.*",
				"jdk.*",
				"sun.*",
			},
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			hashCodeEquals = {
				useJava7Objects = true,
			},
			useBlocks = true,
		},
	},
}

config.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Highlighting references.
	-- See: https://sbulav.github.io/til/til-neovim-highlight-references/
	-- for the highlight trigger time see: `vim.opt.updatetime`
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = true,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Document Highlight",
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Clear All the References",
		})
	end

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = {
		noremap = true,
		silent = true,
		buffer = bufnr,
	}
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({
			async = true,
		})
	end, bufopts)

	-- jdtls-specific refactoring keymaps
	vim.keymap.set("n", "<space>ev", function()
		require("jdtls").extract_variable()
	end, { noremap = true, silent = true, buffer = bufnr, desc = "Extract variable" })
	vim.keymap.set("v", "<space>ev", function()
		require("jdtls").extract_variable(true)
	end, { noremap = true, silent = true, buffer = bufnr, desc = "Extract variable" })
	vim.keymap.set("n", "<space>ec", function()
		require("jdtls").extract_constant()
	end, { noremap = true, silent = true, buffer = bufnr, desc = "Extract constant" })
	vim.keymap.set("v", "<space>ec", function()
		require("jdtls").extract_constant(true)
	end, { noremap = true, silent = true, buffer = bufnr, desc = "Extract constant" })
	vim.keymap.set("v", "<space>em", function()
		require("jdtls").extract_method(true)
	end, { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" })
	vim.keymap.set("n", "<space>oi", function()
		require("jdtls").organize_imports()
	end, { noremap = true, silent = true, buffer = bufnr, desc = "Organize imports" })
end

require("jdtls").start_or_attach(config)
