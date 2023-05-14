vim.opt.termguicolors = true

-- if we don't do augroup, the highlight command doesn't work
-- for dapui color, see https://github.com/rcarriga/nvim-dap-ui/blob/4ce7b97dd8f50b4f672948a34bf8f3a56214fdb8/lua/dapui/config/highlights.lua
vim.cmd([[

colo primary

augroup MyColors
autocmd!

autocmd ColorScheme * highlight DiagnosticWarn ctermfg=3 guifg=#9D5214
autocmd ColorScheme * highlight DiagnosticHint ctermfg=7 guifg=#000000
autocmd ColorScheme * highlight Visual cterm=reverse
autocmd ColorScheme * highlight Pmenu guibg=#fddde6
autocmd ColorScheme * highlight VertSplit ctermbg=NONE guibg=NONE

autocmd ColorScheme * highlight DapUIStepOut guifg=#9D5214
autocmd ColorScheme * hi DapUIStepOver guifg=#9D5214
autocmd ColorScheme * hi DapUIStepInto guifg=#9D5214
autocmd ColorScheme * hi DapUIStepBack guifg=#9D5214
autocmd ColorScheme * hi DapUIScope guifg=#9D5214
autocmd ColorScheme * hi DapUIBreakpointsPath guifg=#9D5214
autocmd ColorScheme * hi DapUILineNumber guifg=#9D5214
autocmd ColorScheme * hi DapUIPlayPause guifg=#ff0000
autocmd ColorScheme * hi DapUIRestart guifg=#ff0000

augroup end
]])
