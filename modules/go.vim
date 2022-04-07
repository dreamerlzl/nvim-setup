
" for ray-x
autocmd BufWritePre *.go :silent! lua require("go.format").goimport()

lua << END

local nvim_lsp = require'lspconfig'

-- Run gofmt + goimport on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

-- for golang
nvim_lsp.gopls.setup {
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow=true,
      },
      staticcheck = true,
    },
  },
}

require('go').setup()
-- require("go.format").goimport()  -- goimport + gofmt
END
