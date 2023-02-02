" custom setting for clangformat
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

lua << END

require("clangd_extensions").setup({
  server = {
    cmd = {
      "clangd",
      "--resource-dir=/usr/lib64/clang/14",
    },
  },
})

END
