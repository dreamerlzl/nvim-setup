require("symbols-outline").setup()
require("scrollbar").setup()
require('leap').add_default_mappings()
-- remove leap's forward till mapping
vim.keymap.del({'o', 'x'}, 'x')

vim.g.rooter_patterns = {'.git', 'Cargo.toml', 'go.mod', 'Pipfile'}
