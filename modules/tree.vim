let g:NERDTreeMapJumpNextSibling = ''
nnoremap <C-t> :call NERDTreeToggleAndRefresh()<CR>
" use leaderf instead
" nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-n> :call NumBarToggle()<CR>

function NumBarToggle()
  set invnumber
  :ScrollbarToggle
endfunction

function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

-- show current symbol's definition when cursor is held
require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = { enable = true },
  },
}
EOF
 
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" enable tree-sitter's highlight module
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages

    -- if not disable, will fuck up rust.vim's folding
    disable = {"rust" }, 
    additional_vim_regex_highlighting = false,
  },
}
EOF
