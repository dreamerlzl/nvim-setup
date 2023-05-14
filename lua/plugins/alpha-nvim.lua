local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	"██╗    ██╗██████╗ ██╗ ██████╗ ██╗  ██╗████████╗",
	"██║    ██║██╔══██╗██║██╔════╝ ██║  ██║╚══██╔══╝",
	"██║ █╗ ██║██████╔╝██║██║  ███╗███████║   ██║   ",
	"██║███╗██║██╔══██╗██║██║   ██║██╔══██║   ██║   ",
	"╚███╔███╔╝██║  ██║██║╚██████╔╝██║  ██║   ██║   ",
	" ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝ ",
}

dashboard.section.buttons.val = {
	dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
	--dashboard.button("f", "  > Find file", ":LeaderfFile<CR>"),
	--dashboard.button("w", "  > Find word", ':<C-U><C-R>=printf("Leaderf! rg -e ")<CR>'),
	dashboard.button("l", " > Plugins", ":Lazy<CR>"),
	dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)
