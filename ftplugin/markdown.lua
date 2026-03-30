-- Wrap the visual selection in HTML comment markers.
-- Inserts <!-- above the first selected line and --> below the last.
local function wrap_in_html_comment()
	-- '< and '> are only committed when visual mode exits. This function runs
	-- while visual mode is still active, so use 'v' (selection anchor) and
	-- '.' (cursor position) which reflect the live selection instead.
	local start_row = vim.fn.line("v")
	local end_row = vim.fn.line(".")
	if start_row > end_row then
		start_row, end_row = end_row, start_row
	end

	-- Insert end marker first so the start-row index is not shifted.
	vim.api.nvim_buf_set_lines(0, end_row, end_row, false, { "-->" })
	vim.api.nvim_buf_set_lines(0, start_row - 1, start_row - 1, false, { "<!--" })
end

vim.keymap.set("x", "gc", wrap_in_html_comment, {
	buffer = true,
	silent = true,
	desc = "Wrap selection in HTML comment",
})
