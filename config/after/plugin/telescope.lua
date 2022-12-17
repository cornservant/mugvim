local builtin = require 'telescope.builtin'

require("which-key").register({
    p = {
        name = "Project",
        f = { builtin.find_files, "Find Files" },
        s = { builtin.git_files, "Git Files" },
    },
    t = {
        name = "Telescope",
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
        m = { "<cmd>Telescope marks<cr>", "Marks" },
        j = { "<cmd>Telescope jumplist<cr>", "Jumplist" },
        f = { "<cmd>Telescope find_files<cr>", "Files" },
        t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    },
}, { prefix = "<leader>"})
