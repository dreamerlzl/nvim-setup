
" for ray-x
autocmd BufWritePre *.go :silent! lua require("go.format").goimport()

lua << END

local nvim_lsp = require'lspconfig'

-- for golang
nvim_lsp.gopls.setup {
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

require('go').setup()
-- require("go.format").goimport()  -- goimport + gofmt
END
