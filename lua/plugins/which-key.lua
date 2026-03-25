return function()
	local wk = require("which-key")
	wk.setup()
	wk.add({
		{ "<leader>h", group = "harpoon" },
	})
end
