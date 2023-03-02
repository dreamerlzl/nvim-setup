vim.opt.termguicolors = true

-- if we don't do augroup, the highlight command doesn't work
vim.cmd [[

colo primary

augroup MyColors
autocmd!

autocmd ColorScheme * highlight DiagnosticWarn ctermfg=3 guifg=#9D5214
autocmd ColorScheme * highlight DiagnosticHint ctermfg=7 guifg=#000000
autocmd ColorScheme * highlight Visual cterm=reverse
autocmd ColorScheme * highlight SignColumn guibg=NONE
autocmd ColorScheme * highlight LineNr guibg=None

augroup end
]]
