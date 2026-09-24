-- Mostly Gemini slopped startup benchmark

local M = {
    measurements = {},
}

-- Create a dedicated namespace for highlights
local ns_id = vim.api.nvim_create_namespace("bench_highlights")

--- @param name string
--- @param action fun()
function M:bench(name, action)
    local start = os.clock()
    action()
    local stop = os.clock()
    local duration_ms = 1000 * (stop - start)
    table.insert(M.measurements, {
        name = name,
        duration_ms = duration_ms,
    })
end

--- Formats bench data and tracks indices of top 3 durations
function M:render_to_buffer()
    if #M.measurements == 0 then
        vim.notify("No benchmarks recorded yet!", vim.log.levels.WARN)
        return
    end

    -- 1. Identify the top 3 highest durations
    local indexed_list = {}
    for i, entry in ipairs(M.measurements) do
        table.insert(indexed_list, { idx = i, duration = entry.duration_ms })
    end
    table.sort(indexed_list, function(a, b) return a.duration > b.duration end)

    local top_3_lookup = {}
    if indexed_list[1] then top_3_lookup[indexed_list[1].idx] = "DiagnosticError" end -- #1 Highest (Red)
    if indexed_list[2] then top_3_lookup[indexed_list[2].idx] = "DiagnosticWarn" end  -- #2 Highest (Yellow)
    if indexed_list[3] then top_3_lookup[indexed_list[3].idx] = "DiagnosticInfo" end  -- #3 Highest (Blue)

    -- 2. Build buffer content lines
    local lines = {
        "┌──────────────────────────────────┬───────────────┐",
        "│ Benchmark Name                   │ Duration      │",
        "├──────────────────────────────────┼───────────────┤",
    }

    local data_start_row = 3 -- Line index where benchmark data starts (0-indexed line 3)

    for _, entry in ipairs(M.measurements) do
        local name_col = string.format("%-32s", entry.name:sub(1, 32))
        local time_col = string.format("%10.3f ms", entry.duration_ms)
        table.insert(lines, string.format("│ %s │ %s │", name_col, time_col))
    end

    table.insert(lines, "└──────────────────────────────────┴───────────────┘")
    table.insert(lines, "Press 'q' or '<Esc>' to close this buffer.")

    -- 3. Create a scratch buffer
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)

    -- 4. Apply highlights to top 3 lines
    for i, _ in ipairs(M.measurements) do
        local hl_group = top_3_lookup[i]
        if hl_group then
            local line_row = data_start_row + (i - 1)
            -- Highlight the full data row
            vim.api.nvim_buf_add_highlight(bufnr, ns_id, hl_group, line_row, 0, -1)
        end
    end

    -- 5. Open in split window
    vim.cmd("split")
    local winnr = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(winnr, bufnr)

    -- 6. Configure buffer options (Read-Only)
    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].bufhidden = "wipe"
    vim.bo[bufnr].modifiable = false
    vim.bo[bufnr].readonly = true

    -- 7. Keymaps to close on 'q' or '<Esc>'
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
    vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", opts)
end

return M
