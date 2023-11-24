# ov

- my neovim setup with
  - lazy.nvim
  - null-ls for formatting
  - mason for managing lsp
  - harpoon for file navigation
  - noice for floating cmdline
  - lualine for status line
- configs for plugin can be found under `lua/plugins`
- for rust, python, golang, lua and typescript dev

# prerequisite(separate installation)

- command-line utilities (for leaderF)
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [fzf](https://github.com/junegunn/fzf)
- [golangci-lint-langserver](https://github.com/nametake/golangci-lint-langserver)
- for tsserver: `npm install -g typescript`

# faq

- why neo-tree instead of chadtree, nvim-tree and nerdtree for file management?
  - [chadtree doesn't support open a dir](https://github.com/ms-jpq/chadtree/issues/274)
  - nvim-tree doesn't support <enter> to enter a dir in the tree
  - nerdtree is no longer maintained (actually I like it)
- why `leap.nvim` instead of `easymotion`, `vim-sneak`, `hop.nvim` for metajump?
  - when I switch to lua config and lazy.nvim, `vim-sneak` stop working.
  - `hop.nvim` is buggy
  - `leap.nvim` is more actively maintained, and the design is better
- why nvim-cmp instead of coq.nvim, mini.completion for autocompletion?
  - coq.nvim makes my neovim crash from time to time; nvim-cmp never.
  - mini.completion is neat, but it's not as feature-rich as nvim-cmp.
- why nvim-dap instead of vim-inspector?
  - more convenient to debug unit tests
- about neovim's [folding](https://neovim.io/doc/user/fold.html)
  - here expr fold is used
- my leaderF doesn't work
  - execute `:checkhealth` and see pynvim is ok or not
