return {
    "epwalsh/obsidian.nvim",
    version = "*",
    enabled = vim.g.mugvim_obsidian_workspaces and true or false,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("obsidian").setup({
            workspaces = vim.g.mugvim_obsidian_workspaces or {}
        })
    end,
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
