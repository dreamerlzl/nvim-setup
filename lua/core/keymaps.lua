local function map(mode, lhs, rhs, opts)
    local options = {
        noremap = true
        -- for use of leaderf rg, better set silent = false
        -- silent = true
    }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


vim.cmd [[
nnoremap <C-s> :call ToggleSignColumn()<CR>
" Toggle signcolumn. Works on vim>=8.1 or NeoVim
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=number
        let b:signcolumn_on=1
    endif
endfunction
]]

-- Toggle LineNumberColumn
map('n', '<C-n>', ':set invnumber | exec ToggleAll() <CR>')

vim.cmd [[

function ToggleAll()
  :ScrollbarToggle
  :IndentBlanklineToggle
endfunction

]]

-- buffers
-- for switching tabs
map('n', 'J', 'gT')
map('n', 'K', 'gt')
-- for delete without copy
map('v', 'd', '"_d')
map('v', 'p', '"+p')
map('v', 'y', '"+y')

vim.keymap.set("n", "<Space>", "<Nop>", {
    silent = true
})
vim.g.mapleader = " "

-- Symbols Outline
map('n', '<C-l>', ':SymbolsOutline<CR>')

-- leaderf
map('', '<C-J>', ':<C-U><C-R>=printf("Leaderf! rg -e ")<CR>')
map('', '<C-F>', ':LeaderfFile<CR>')
map('n', '<leader>gm', '<Plug>(git-messenger)')
