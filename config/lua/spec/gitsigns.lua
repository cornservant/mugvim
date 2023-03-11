return {
    'lewis6991/gitsigns.nvim',
    config = function()
        local gs = require("gitsigns");
        local wk = require("which-key");

        gs.setup{}

        wk.register({
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
    end,
}
