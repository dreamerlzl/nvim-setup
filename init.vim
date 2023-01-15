" for vscode and local setup
if exists('g:vscode')
    " vscode settings
    source $HOME/.config/nvim/vscode.vim
else
    " no spell check for markdown
    autocmd FileType markdown setlocal nospell
    autocmd FileType python colorscheme toast
    autocmd FileType go colorscheme toast
    autocmd FileType c colorscheme PaperColor

    " empty tab completion
    " inoremap <silent><expr> <c-space> coc#refresh()

    call plug#begin('~/.vim/plugged')

    " for fzf selection
    Plug 'stevearc/dressing.nvim'
    Plug 'petertriho/nvim-scrollbar'
    " symbols outline
    Plug 'simrat39/symbols-outline.nvim'

    " for clang
    Plug 'p00f/clangd_extensions.nvim'
    Plug 'sbdchd/neoformat'

    "auto-set cwd; for leaderf
    Plug 'airblade/vim-rooter'

    Plug 'kyazdani42/nvim-web-devicons'
    " Plug 'folke/trouble.nvim'
    " for delaying lsp diag
    Plug 'https://gitlab.com/yorickpeterse/nvim-dd.git'

    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'

    " use this instead; see https://www.reddit.com/r/neovim/comments/scm1ob/fidgetnvim_a_standalone_ui_for_for_nvimlsp/
    Plug 'j-hui/fidget.nvim'

    " meta-jump
    Plug 'justinmk/vim-sneak'

    " for status line
    Plug 'nvim-lualine/lualine.nvim'

    " git support
    Plug 'airblade/vim-gitgutter'
    Plug 'rhysd/git-messenger.vim'

    " syntax tree parser 
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

    " symbol def under cursor
    Plug 'nvim-treesitter/nvim-treesitter-refactor'

   " " async
    Plug 'nvim-lua/plenary.nvim'

    " rename, better UI
    Plug 'glepnir/lspsaga.nvim'

    " Collection of common configurations for the Nvim LSP client
    Plug 'neovim/nvim-lspconfig'

    " Completion framework
    Plug 'hrsh7th/nvim-cmp'

    " LSP completion source for nvim-cmp
    Plug 'hrsh7th/cmp-nvim-lsp'

    " Snippet completion source for nvim-cmp
    Plug 'hrsh7th/cmp-vsnip'

    " Other usefull completion sources
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'

    " launch ra, add hover action, run test, debug, etc. 
    Plug 'simrat39/rust-tools.nvim'

    " for fmt on save
    Plug 'rust-lang/rust.vim'

    " Snippet engine
    Plug 'hrsh7th/vim-vsnip'

    " for auto pair completion
    " Plug 'rstacruz/vim-closer'

    " for file tree explorer
    Plug 'preservim/nerdtree'

    " for golang
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'crispgm/nvim-go', {'do': ':GoUpdateBinaries'}

    Plug 'rcarriga/nvim-notify'

    call plug#end()

    source $HOME/.config/nvim/modules/lualine.vim
    source $HOME/.config/nvim/modules/general.vim
    source $HOME/.config/nvim/modules/tree.vim
    source $HOME/.config/nvim/modules/lsp.vim
    source $HOME/.config/nvim/modules/rust.vim
    " note that go.vim depends on treesitter
    source $HOME/.config/nvim/modules/go.vim
    source $HOME/.config/nvim/modules/python.vim
    " source $HOME/.config/nvim/modules/vimspector.vim
    source $HOME/.config/nvim/modules/leaderf.vim
    source $HOME/.config/nvim/modules/dap.vim
    source $HOME/.config/nvim/modules/trouble.vim
    source $HOME/.config/nvim/modules/sneak.vim
    source $HOME/.config/nvim/modules/rooter.vim
    source $HOME/.config/nvim/modules/clang.vim
    source $HOME/.config/nvim/modules/notify.vim
    
    if exists("g:neovide")
      source $HOME/.config/nvim/modules/neovide.vim
    endif

endif
