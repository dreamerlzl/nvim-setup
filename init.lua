-- Bootstrap globals: must execute before any plugin manager or plugin code

vim.g.mapleader = " "

-- Set before lazy so live-server.nvim sees it (avoids require().setup() deprecation)
vim.g.live_server = { args = {} }

-- Disable builtin plugins before lazy so the runtime never sources them
-- NOTE: do not disable `ftplugin` here. This config relies on filetype plugins
-- such as `ftplugin/java.lua`, and keeping the runtime ftplugin dispatcher
-- enabled is the safest conservative choice.
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
}
for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

require("core/bigfile")
require("core/lazy")
require("core/autocmds")
require("core/keymaps")
require("core/options")
require("core/colors")
