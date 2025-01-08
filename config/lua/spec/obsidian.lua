return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/git.loporrit.de/obsidian-vault",
            },
            {
                name = "kehrwasser",
                path = "~/git.loporrit.de/kehrwasser-vault",
            },
        },
    },
    keys = {
        { "<leader>ob", "<cmd>ObsidianBacklinks<cr>",   "Backlinks" },
        { "<leader>on", "<cmd>ObsidianNew<cr>",         "New" },
        { "<leader>oo", "<cmd>ObsidianOpen<cr>",        "Open" },
        { "<leader>ot", "<cmd>ObsidianToday<cr>",       "Today" },
        { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", "QuickSwitch" },
        { "<leader>of", "<cmd>ObsidianFollowLink<cr>",  "FollowLink" },
        { "<leader>os", "<cmd>ObsidianSearch<cr>",      "Search" },
        { "<leader>od", "<cmd>ObsidianDailies<cr>",     "Dailies" },
        -- { "<leader>ol", "<cmd>ObsidianLink<cr>",        "link" },
        -- { "<leader>oL", "<cmd>ObsidianLinkNew<cr>",     "LinkNew" },
    },
}
