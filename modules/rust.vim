" rust.vim
" enable folding
let g:rust_fold = 1

" packadd! termdebug
" let g:termdebugger="rust-gdb"

let g:rustfmt_autosave = 1

lua << END
local extension_path = '/home/wright/vscode-lldb/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'


local rt = require("rust-tools")

rt.setup({
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<Leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
            -- allFeatures = true,
            overrideCommand = {
                'cargo', 'clippy', '--workspace', '--message-format=json', '--all-targets',
            }
        },
        inlayHints = { locationLinks = false },
        cargo = {
          features = "all",
        },
        procMacro = {
          enable = true
        },
        imports = {
          granularity = {
            group = "crate",
          },
          prefix = "self",
        },
      }
    }
  },
})

END
