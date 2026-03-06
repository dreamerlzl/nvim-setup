# AGENTS.md - Neovim Configuration

## Overview

This is a Neovim configuration written in Lua using lazy.nvim for plugin management. It supports development in Rust, Python, Go, Lua, TypeScript, and more.

## Project Structure

```
nvim/
├── init.lua              # Main entry point
├── lua/
│   ├── core/             # Core Neovim settings
│   │   ├── lazy.lua      # Plugin manager setup
│   │   ├── options.lua   # Neovim options
│   │   ├── keymaps.lua  # Keybindings
│   │   ├── autocmds.lua  # Autocommands
│   │   ├── statusline.lua
│   │   ├── colors.lua
│   │   └── cmp.lua      # nvim-cmp autocomplete
│   ├── lsp/              # LSP configuration
│   │   ├── lspconfig.lua
│   │   └── go.lua
│   └── plugins/          # Plugin configurations
│       ├── git.lua
│       ├── nvim-dap.lua
│       ├── nvim-treesitter.lua
│       └── ...
└── ftplugin/
    └── java.lua
```

## Build/Lint/Test Commands

### Testing the Configuration

```bash
# Open Neovim and run health check
nvim +":checkhealth" +qa

# Check for Lua syntax errors
luac -p lua/**/*.lua

# Test with verbose startup
nvim --startuptime /tmp/nvim.log
```

### Formatting

```bash
# Format Lua files (via conform.nvim, mapped to <leader>m)
# Or run stylua directly:
stylua --check lua/

# Format Python files
ruff check --select I --fix .
ruff format .
```

### Running Tests

```bash
# Run nearest test (in Neovim)
<leader>tn

# Run test file (in Neovim)
<leader>tf

# Toggle test summary
<leader>ts

# Show test output
<leader>to

# Toggle output panel
<leader>tp
```

### Linting

```bash
# Lua (via lua_ls in Neovim)
# Open any .lua file and LSP will report issues

# Go
golangci-lint run
cargo clippy

# Python
ruff check .
```

## Code Style Guidelines

### General Conventions

1. **File Organization**
   - One require per line at the top of files
   - Group related requires (core, plugins, lsp)
   - Use modular files under `lua/core/`, `lua/lsp/`, `lua/plugins/`

2. **Indentation**
   - Use 4 spaces (not tabs)
   - Config: `opt.shiftwidth = 4`, `opt.tabstop = 4`, `opt.expandtab = true`

3. **Line Length**
   - No hard limit, but prefer ~100 chars
   - Use `opt.colorcolumn = '80'` for reference

### Lua Conventions

1. **Imports**
   ```lua
   -- Use require for modules
   local status_ok, lazy = pcall(require, "lazy")
   if not status_ok then
       return
   end
   
   -- Use pcall for protected require
   ```

2. **Variables**
   ```lua
   local g = vim.g           -- Global variables
   local opt = vim.opt       -- Options
   local fn = vim.fn          -- Functions
   local api = vim.api        -- API
   ```

3. **Keymaps**
   ```lua
   -- Preferred: vim.keymap.set (modern)
   vim.keymap.set("n", "<leader>ff", function()
       -- code
   end, { silent = true, desc = "Find files" })
   
   -- Legacy: vim.api.nvim_set_keymap
   map("n", "<C-s>", ":call ToggleSignColumn()<CR>")
   ```

4. **Plugin Setup**
   ```lua
   -- Use table-style setup
   require("plugin_name").setup({
       option = value,
   })
   
   -- Or with opts
   require("plugin_name").setup(opts)
   
   -- Lazy loading
   {
       "author/plugin",
       event = "BufRead",        -- or "InsertEnter", "VeryLazy"
       ft = { "lua", "vim" },    -- filetype
       keys = { ... },           -- lazy-load on keybind
   }
   ```

5. **Error Handling**
   ```lua
   -- Always use pcall for loading plugins
   local status_ok, plugin = pcall(require, "plugin")
   if not status_ok then
       return
   end
   ```

6. **Naming Conventions**
   - Variables: `camelCase` or `snake_case`
   - Tables/Modules: `snake_case`
   - File names: `snake_case.lua`
   - Keymap descriptions: "Description" (title case)

7. **Formatting**
   - Use stylua for Lua formatting
   - Config in `lua/core/lazy.lua`:
   ```lua
   formatters_by_ft = {
       lua = { "stylua" },
       python = { "ruff_organize_imports", "ruff_format" },
   }
   ```

### Vimscript Conventions (in vim.cmd)

- Use double quotes for strings
- Use `-- comment` for comments
- Keep vimscript minimal; prefer Lua

### LSP Configuration

```lua
-- Standard on_attach pattern
local on_attach = function(client, bufnr)
    -- Map keys
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
end

-- Use vim.lsp.config for new API (Neovim 0.10+)
vim.lsp.config("rust_analyzer", {
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable("rust_analyzer")
```

### Testing Guidelines

- Use neotest for running tests
- Configure adapters in plugin setup
- Java tests: `nvim-neotest/nvim-nio` + `rcasia/neotest-java`

## Key Dependencies

- **Plugin Manager**: lazy.nvim
- **LSP**: nvim-lspconfig, mason.nvim
- **Completion**: nvim-cmp
- **Treesitter**: nvim-treesitter
- **Formatter**: conform.nvim (stylua, ruff)
- **Debug**: nvim-dap
- **UI**: lualine, noice.nvim, which-key.nvim

## Common Tasks

### Add a New Plugin

1. Add to `lua/core/lazy.lua` in the spec table
2. Configure in a new file under `lua/plugins/` if complex
3. Add keymaps in `lua/core/keymaps.lua` if needed

### Add a New LSP Server

1. Install via Mason: `:MasonInstall <server>`
2. Add to servers list in `lua/lsp/lspconfig.lua`
3. Configure in the same file if custom settings needed

### Modify Keybindings

Edit `lua/core/keymaps.lua`. Use `vim.keymap.set()` for new bindings.

## External Tools Required

- `stylua` - Lua formatter
- `ruff` - Python formatter/linter
- `ripgrep` - For LeaderF
- `fzf` - For fuzzy finding
- `golangci-lint` - Go linter
- `node` >= 20.19.0 - For TypeScript LSP
