return function()
	require("toggleterm").setup({
		open_mapping = [[<c-\>]],
		direction = "float",
	})
end

--local Terminal  = require('toggleterm.terminal').Terminal
--local lazygit = Terminal:new({ cmd = "gitui", hidden = true })
--
--function _gitui_toggle()
--  lazygit:toggle()
--end
--
--vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _gitui_toggle()<CR>", {noremap = true, silent = true})
