local M = {}

function M.setup()
    local gs = require("gitsigns");

    gs.setup({})

    require("which-key").register({
        g = {
            name = "Git",
            j = { function() gs.next_hunk({ navigation_message = false }) end, "Next Hunk" },
            k = { function() gs.prev_hunk({ navigation_message = false }) end, "Prev Hunk" },
            l = { function() gs.blame_line() end, "Blame" },
            p = { function() gs.preview_hunk() end, "Preview Hunk" },
            r = { function() gs.reset_hunk() end, "Reset Hunk" },
            R = { function() gs.reset_buffer() end, "Reset Buffer" },
            s = { function() gs.stage_hunk() end, "Stage Hunk" },
            u = { function() gs.undo_stage_hunk() end, "Undo Stage Hunk" },
            d = { function() gs.diffthis() end, "Git Diff" },
        }
    }, { prefix = "<leader>" })
end

return M
