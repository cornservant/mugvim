return {
    'dmtrKovalenko/fff.nvim',
    build = "cargo build --relase",
    opts = {},
    keys = {
        { "<leader>F", function() require("fff").find_files() end, desc = "Open file picker", },
    },
}
