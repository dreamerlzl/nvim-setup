" for vscode and local setup
if exists('g:vscode')
    " vscode settings
    source $HOME/.config/nvim/vscode.vim
else
    source $HOME/.config/nvim/modules/general.vim

    " empty tab completion
    " inoremap <silent><expr> <c-space> coc#refresh()

    call plug#begin('~/.vim/plugged')

    Plug 'dstein64/vim-startuptime'

    "auto-set cwd; for leaderf
    Plug 'airblade/vim-rooter'
    " Plug 'kyazdani42/nvim-web-devicons'
    " Plug 'folke/trouble.nvim'

    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'

    " debug
    " Plug 'puremourning/vimspector'

    " Plug 'arkav/lualine-lsp-progress'

    Plug 'justinmk/vim-sneak'

    Plug 'nvim-lua/lsp-status.nvim'

    " for guru
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'rcarriga/nvim-notify'
    Plug 'crispgm/nvim-go', {'do': ':GoUpdateBinaries'}
    " Plug 'ray-x/guihua.lua'
    " Plug 'ray-x/go.nvim'

    Plug 'jiangmiao/auto-pairs'

    " for status line
    Plug 'nvim-lualine/lualine.nvim'

    " git support
    Plug 'airblade/vim-gitgutter'

    " syntax tree parser 
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

    " symbol def under cursor
    Plug 'nvim-treesitter/nvim-treesitter-refactor'

   " " async
    Plug 'nvim-lua/plenary.nvim'

    " rename, better UI
    Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

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
    " Plug 'simrat39/rust-tools.nvim'

    " for fmt on save
    " Plug 'rust-lang/rust.vim'

    " Snippet engine
    Plug 'hrsh7th/vim-vsnip'

    " for auto pair completion
    " Plug 'rstacruz/vim-closer'

    " for file tree explorer
    Plug 'preservim/nerdtree'

    call plug#end()

    source $HOME/.config/nvim/modules/tree.vim
    source $HOME/.config/nvim/modules/lualine.vim
    source $HOME/.config/nvim/modules/lsp.vim
    " source $HOME/.config/nvim/modules/rust.vim
    " note that go.vim depends on treesitter
    source $HOME/.config/nvim/modules/go.vim
    " source $HOME/.config/nvim/modules/python.vim
    source $HOME/.config/nvim/modules/leaderf.vim
    source $HOME/.config/nvim/modules/dap.vim
    " source $HOME/.config/nvim/modules/trouble.vim
    source $HOME/.config/nvim/modules/sneak.vim
    source $HOME/.config/nvim/modules/rooter.vim

endif
