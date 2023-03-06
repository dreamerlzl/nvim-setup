-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------
-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim
-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end

-- Start setup
lazy.setup({
    spec = { -- go
    {
        "ray-x/go.nvim",
        requires = { -- optional packages
        "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter"},
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'}
    }, -- rust
    {'https://gitlab.com/yorickpeterse/nvim-dd.git'}, {'rust-lang/rust.vim'}, {'simrat39/rust-tools.nvim'}, -- common stuff
    {'stevearc/dressing.nvim'}, {'godlygeek/tabular'}, {'petertriho/nvim-scrollbar'}, -- statusline
    {'mrjones2014/nvim-ts-rainbow'}, {'j-hui/fidget.nvim'}, {
        'nvim-lualine/lualine.nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'}
    }, -- Icons
    {
        'nvim-tree/nvim-web-devicons',
        lazy = true
    }, -- Dashboard (start screen)
    {
        'goolord/alpha-nvim',
        dependencies = {'nvim-tree/nvim-web-devicons'}
    }, -- Git
    {'rhysd/git-messenger.vim'}, {
        'lewis6991/gitsigns.nvim',
        lazy = true,
        dependencies = {'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons'}
    }, -- meta jump
    {
        'ggandor/leap.nvim',
        dependencies = {'tpope/vim-repeat'}
    }, {'RRethy/vim-illuminate'}, {
        'Yggdroot/LeaderF',
        build = ':LeaderfInstallCExtension'
    }, {'airblade/vim-rooter'}, {'simrat39/symbols-outline.nvim'}, -- File explorer
     -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    }, -- Indent line
    {'lukas-reineke/indent-blankline.nvim'}, -- Tag viewer
    -- { 'preservim/tagbar' },
    {'rcarriga/nvim-notify'}, -- Autopair
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup {}
        end


    }, -- LSP
    {'neovim/nvim-lspconfig'}, {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        config = function()
            require("lspsaga").setup({})
        end
,
        dependencies = {{"nvim-tree/nvim-web-devicons"}, {"nvim-treesitter/nvim-treesitter"}}
    }, -- tree
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
      },
      keys = {
        { "<C-t>", ":Neotree toggle reveal=true<CR>" },
      },
      init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        if vim.fn.argc() == 1 then
          local stat = vim.loop.fs_stat(vim.fn.argv(0))
          if stat and stat.type == "directory" then
            require("neo-tree")
          end
        end
      end,
      opts = { -- make lazy manage your config
        follow_current_file = true,
        filesystem = {
          hijack_netrw_behavior = "open_current",
        }
      }
    },
    -- Autocomplete
    {
        'hrsh7th/nvim-cmp',
        -- load cmp on InsertEnter
        event = 'InsertEnter',
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {'L3MON4D3/LuaSnip', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-buffer',
                        'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip'}
    }}
}, {
    install = {
        colorscheme = {"shine"}
    }
})
