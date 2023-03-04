# ov
- my neovim setup with lua + lazy.nvim
- configs for plugin can be found under `lua/plugins`
- for python, golang and rust dev

# prerequisite(separate installation)
- command-line utilities (for leaderF)
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [fzf](https://github.com/junegunn/fzf)
- python
  - [pynvim](https://github.com/neovim/pynvim)
  - pyright: `npm i -g pyright`
- rust
  - [rust-analyzer](https://rust-analyzer.github.io/manual.html#installation)
  - [codelldb](https://github.com/vadimcn/vscode-lldb/releases)
    - install, unzip and modify the execution path in `modules/rust.vim`
    - note: rust-tools has problems with codelldb > 1.6.10

# faq
- why `leap.nvim` instead of `easymotion`, `vim-sneak`, `hop.nvim`?
    - when I switch to lua config and lazy.nvim, `vim-sneak` stop working.
    - `hop.nvim` is buggy
    - `leap.nvim` is more actively maintained, and the design is better
- why nvim-dap instead of vim-inspector?
  - more convenient to debug unit tests
- about neovim's [folding](https://neovim.io/doc/user/fold.html)
  - here expr fold is used
