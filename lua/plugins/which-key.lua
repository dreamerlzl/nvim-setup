local wk = require("which-key")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

wk.setup()
wk.add({
	{ "<leader>h", group = "harpoon" },
	{ "<leader>ha", mark.add_file, desc = "Add file to harpoon" },
	{ "<leader>hl", ui.toggle_quick_menu, desc = "Toggle quick menu" },
	{ "<leader>hr", mark.rm_file, desc = "Remove file from harpoon" },
})

vim.cmd([[
  nnoremap <silent><A-1> :lua require("harpoon.ui").nav_file(1)<CR>
  nnoremap <silent><A-2> :lua require("harpoon.ui").nav_file(2)<CR>
  nnoremap <silent><A-3> :lua require("harpoon.ui").nav_file(3)<CR>
  nnoremap <silent><A-4> :lua require("harpoon.ui").nav_file(4)<CR>
]])
