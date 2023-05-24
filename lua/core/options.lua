-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*
local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------

vim.cmd([[
set tabline=%!MyTabLine()
set fileencoding=utf-8

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s ..= '%#TabLineSel#'
    else
      let s ..= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s ..= '%' .. (i + 1) .. 'T'

    " the label is made by MyTabLabel()
    let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s ..= '%#TabLineFill#%T'

  return s
endfunction
]])

-- opt.mouse = 'a' -- Enable mouse support
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = "menuone,noinsert,noselect" -- Autocomplete options
opt.updatetime = 300

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.cursorline = true
opt.showmatch = true -- Highlight matching parenthesis
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.foldcolumn = "auto"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr" -- Enable folding (default 'foldmarker')
opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.colorcolumn = '80' -- Line lenght marker at 80 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.laststatus = 3 -- Set global statusline

vim.cmd([[

" for prog lang syntax highlight
syntax enable
filetype plugin indent on

]])
-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = false -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append("sI")
opt.timeout = true
opt.timeoutlen = 300

-- -- Disable builtin plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
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
	"ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end

-- misc
g.colorscheme_primary_disable_italic = 1

vim.cmd([[
let g:sneak#label = 1
]])
