local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
local api = vim.api

local function is_large_buffer(bufnr)
    local max_filesize = 200 * 1024
    local ok, stats = pcall(vim.uv.fs_stat, api.nvim_buf_get_name(bufnr))
    return ok and stats and stats.size > max_filesize
end

local function limit_cmp_for_large_buffers(bufnr)
    if not is_large_buffer(bufnr) then
        return
    end

    cmp.setup.buffer({
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
        },
    })
end

require("luasnip.loaders.from_vscode").lazy_load()

api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    callback = function(args)
        limit_cmp_for_large_buffers(args.buf)
    end,
})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-s>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	sources = {
		{
			name = "nvim_lsp",
		},
		{
			name = "luasnip",
		},
		{
			name = "path",
		},
		{
			name = "buffer",
			keyword_length = 3,
			option = {
				get_bufnrs = function()
					return { api.nvim_get_current_buf() }
				end,
			},
		},
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
		}),
	},
})
