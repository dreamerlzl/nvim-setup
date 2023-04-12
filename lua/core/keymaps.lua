local function map(mode, lhs, rhs, opts)
	local options = {
		noremap = true,
		-- for use of leaderf rg, better set silent = false
		-- silent = true
	}
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--vim.cmd([[
--nnoremap <C-s> :call ToggleSignColumn()<CR>
--" Toggle signcolumn. Works on vim>=8.1 or NeoVim
--function! ToggleSignColumn()
--    if !exists("b:signcolumn_on") || b:signcolumn_on
--        set signcolumn=no
--        let b:signcolumn_on=0
--    else
--        set signcolumn=number
--        let b:signcolumn_on=1
--    endif
--endfunction
--]])

map("n", "<C-s>", ":call ToggleSignColumn()<CR>")
function ToggleSignColumn()
	if not vim.b.signcolumn_on or vim.b.signcolumn_on == 1 then
		vim.opt.signcolumn = "no"
		vim.b.signcolumn_on = 0
	else
		vim.opt.signcolumn = "number"
		vim.b.signcolumn_on = 1
	end
end

-- Toggle LineNumberColumn
map("n", "<C-n>", ":set invnumber | lua ToggleAll() <CR>")

function ToggleAll()
	vim.cmd("ScrollbarToggle")
	vim.cmd("IndentBlanklineToggle")
	ToggleFoldColumn()
	ToggleSignColumn()
end

function ToggleFoldColumn()
	if vim.o.foldcolumn == 0 then
		vim.o.foldcolumn = "1"
	else
		vim.o.foldcolumn = "0"
	end
end

-- buffers
-- for switching tabs
map("n", "J", "gT")
map("n", "K", "gt")
-- for delete without copy
map("v", "d", '"_d')
map("v", "p", '"+p')
map("v", "y", '"+y')
map("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<Space>", "<Nop>", {
	silent = true,
})
vim.g.mapleader = " "

-- Symbols Outline
map("n", "<C-l>", ":SymbolsOutline<CR>")

-- leaderf
map("", "<C-J>", ':<C-U><C-R>=printf("Leaderf! rg -e ")<CR>')
map("", "<C-F>", ":LeaderfFile<CR>")
map("n", "<leader>gm", "<Plug>(git-messenger)")
