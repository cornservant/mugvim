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
        { "<leader>Ob", "<cmd>ObsidianBacklinks<cr>",   "Backlinks" },
        { "<leader>On", "<cmd>ObsidianNew<cr>",         "New" },
        { "<leader>Oo", "<cmd>ObsidianOpen<cr>",        "Open" },
        { "<leader>Ot", "<cmd>ObsidianToday<cr>",       "Today" },
        { "<leader>Oq", "<cmd>ObsidianQuickSwitch<cr>", "QuickSwitch" },
        { "<leader>Of", "<cmd>ObsidianFollowLink<cr>",  "FollowLink" },
        { "<leader>Os", "<cmd>ObsidianSearch<cr>",      "Search" },
        { "<leader>Od", "<cmd>ObsidianDailies<cr>",     "Dailies" },
        -- { "<leader>Ol", "<cmd>ObsidianLink<cr>",        "link" },
        -- { "<leader>OL", "<cmd>ObsidianLinkNew<cr>",     "LinkNew" },
    },
}
