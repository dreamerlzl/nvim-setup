require("dap")
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

vim.cmd([[
  nnoremap <Leader>b :lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <Leader>c :lua require'dap'.continue()<CR>
  nnoremap <Leader>o :lua require'dap'.step_over()<CR>
  nnoremap <Leader>s :lua require'dap'.step_into()<CR>
  nnoremap <Leader>r :lua require'dap'.repl.open()<CR>
  nnoremap <Leader>u :lua require('dapui').toggle()<CR>
]])

require("dapui").setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				-- "stacks",
				-- "watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
})
