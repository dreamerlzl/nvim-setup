let g:go_auto_type_info = 0
let g:go_def_mapping_enabled=0
let g:go_doc_keywordprg_enabled = 0

" for vim-go
autocmd FileType go nmap gh <Plug>(go-info)
autocmd FileType go nmap gd <Plug>(go-def)
autocmd FileType go nmap gc <Plug>(go-callers)
autocmd FileType go nmap gi <Plug>(go-implements)

" for ray-x
" autocmd BufWritePre *.go :silent! lua require("go.format").goimport()

lua << END

local nvim_lsp = require'lspconfig'

-- Run gofmt + goimport on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)


-- for golang
nvim_lsp.gopls.setup {
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow=true,
      },
      staticcheck = true,
    },
  },
}

require('go').setup({
    notify = true,
})
--require('go').setup({
--  run_in_floaterm = true,
--})
-- require("go.format").goimport()  -- goimport + gofmt
END
