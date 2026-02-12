-- only for imports
-- Set before lazy so live-server.nvim sees it (avoids require().setup() deprecation)
vim.g.live_server = {
    args = {}
}

require("core/lazy")
require("core/autocmds")
require("core/keymaps")
require("core/statusline")
require("core/options")
require("core/colors")
require("core/cmp")

require("lsp/lspconfig")
require("lsp/go")

require("plugins/nvim-dap")
require("plugins/indent-blankline")
require("plugins/nvim-treesitter")
require("plugins/git")
require("plugins/alpha-nvim")
require("plugins/leaderf")
require("plugins/misc")
require("plugins/notify")
require("plugins/toggleterm")
require("plugins/which-key")
-- require("plugins/delimiters")
require("plugins/live_server")
