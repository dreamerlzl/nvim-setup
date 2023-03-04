vim.lsp.set_log_level("WARN")

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
    return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
    return
end

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Highlighting references.
    -- See: https://sbulav.github.io/til/til-neovim-highlight-references/
    -- for the highlight trigger time see: `vim.opt.updatetime`
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = true
        })
        vim.api.nvim_clear_autocmds {
            buffer = bufnr,
            group = "lsp_document_highlight"
        }
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight"
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References"
        })
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr
    }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end
, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format {
            async = true
        }
    end
, bufopts)
end


-- Diagnostic settings:
-- see: `:help vim.diagnostic.config`
-- Customizing how diagnostics are displayed
vim.diagnostic.config({
    update_in_insert = false,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
})

-- Show line diagnostics automatically in hover window
vim.cmd([[
  autocmd CursorHold * lua vim.diagnostic.get(0)
]])

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {
    noremap = true,
    silent = true
}
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

--[[
Language servers setup:

For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

Language server installed:

Bash          -> bashls
Python        -> pyright
C-C++         -> clangd
HTML/CSS/JSON -> vscode-html-languageserver
JavaScript/TypeScript -> tsserver
--]]

-- TODO: root dir setup

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:
local servers = {'bashls', 'pyright', 'clangd', 'html', 'cssls', 'tsserver'}

-- Call setup
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        root_dir = root_dir,
        capabilities = capabilities,
        flags = {
            -- default in neovim 0.7+
            debounce_text_changes = 150
        }
    }
end

vim.g.rustfmt_autosave = 1
vim.g.rust_fold = 1

local extension_path = '/home/wright/vscode-lldb/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local rt = require("rust-tools")

rt.setup({
    tools = {
      on_initialized = function(_)
        vim.cmd[[ colo primary ]]
      end,
        inlay_hints = {
            only_current_line = true
        }
    },
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
    },
    server = {
        on_attach = function(client, bufnr)
            vim.keymap.set("n", "<Leader>h", rt.hover_actions.hover_actions, {
                buffer = bufnr
            })
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, {
                buffer = bufnr
            })
            on_attach(client, bufnr)
        end
,
        capabilities = capabilities,
        flags = {
            -- default in neovim 0.7+
            debounce_text_changes = 150
        },
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    -- allFeatures = true,
                    overrideCommand = {'cargo', 'clippy', '--workspace', '--message-format=json', '--all-targets'}
                },
                inlayHints = {
                    locationLinks = false
                },
                cargo = {
                    features = "all"
                },
                procMacro = {
                    enable = true
                },
                imports = {
                    granularity = {
                        group = "crate"
                    },
                    prefix = "self"
                }
            }
        }
    }
})

lspconfig.gopls.setup({
    on_attach = on_attach,
    root_dir = root_dir,
    capabilities = capabilities,
    flags = {
        -- default in neovim 0.7+
        debounce_text_changes = 150
    },
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true
            }
        }
    }
})

require('go').setup({
    lsp_inlay_hints = {
        enable = true,
        only_current_line = true
    }
})

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require 'cmp'
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end


    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-s>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        })
    },

    -- Installed sources
    sources = cmp.config.sources({{
        name = 'nvim_lsp'
    }, {
        name = 'vsnip'
    }, {
        name = 'path'
    }, {
        name = 'buffer'
    }})
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false
})

require("lspsaga").setup({
    symbol_in_winbar = {
        color_mode = false
    }
})
