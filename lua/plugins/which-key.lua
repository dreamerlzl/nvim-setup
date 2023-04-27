local wk = require("which-key")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

wk.setup()
wk.register({
	["<leader>"] = {
		h = {
			name = "harpoon",
			a = { mark.add_file, "Add file to harpoon" },
			l = { ui.toggle_quick_menu, "Toggle quick menu" },
			r = { mark.rm_file, "Remove file from harpoon" },
		},
	},
})
vim.cmd([[
  nnoremap <silent><A-1> :lua require("harpoon.ui").nav_file(1)<CR>
  nnoremap <silent><A-2> :lua require("harpoon.ui").nav_file(2)<CR>
  nnoremap <silent><A-3> :lua require("harpoon.ui").nav_file(3)<CR>
  nnoremap <silent><A-4> :lua require("harpoon.ui").nav_file(4)<CR>
]])
