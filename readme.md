# ov
- my neovim setup
  - configs for plugin can be found under `modules`
  - use vim-plug
- for python, golang and rust dev

# prerequisite(separate installation)
- [pynvim](https://github.com/neovim/pynvim)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- rust
  - [rust-analyzer](https://rust-analyzer.github.io/manual.html#installation)
  - [codelldb](https://github.com/vadimcn/vscode-lldb/releases)
    - install, unzip and modify the execution path in `modules/rust.vim`
    - note: rust-tools has problems with codelldb > 1.6.10

# lsp
- check lsp status `:LspInfo`

# faq
- [why `vim-sneak` instead of `easymotion`?](https://www.reddit.com/r/vim/comments/2ydw6t/large_plugins_vs_small_easymotion_vs_sneak/)
- why nvim-dap instead of vim-inspector?
  - more convenient to debug unit tests
