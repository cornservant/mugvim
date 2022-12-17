-- keymaps
vim.g.mapleader = ' '
vim.keymap.set('i', '<C-[>', '<esc>')
vim.keymap.set('n', '<S-h>', '<cmd>bprev<cr>')
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<C-h>', '<cmd>wincmd h<cr>')
vim.keymap.set('n', '<C-j>', '<cmd>wincmd j<cr>')
vim.keymap.set('n', '<C-k>', '<cmd>wincmd k<cr>')
vim.keymap.set('n', '<C-l>', '<cmd>wincmd l<cr>')
vim.keymap.set('n', '<C-\\>', '<cmd>ToggleTerm<cr>')
-- a fair share of keybindings are introduced by Comment.nvim

-- which-key
require("which-key").register({
    a = { "<cmd>lua require(\"harpoon.mark\").add_file()<cr>", "Harpoon Mark" },
    w = { "<cmd>w<cr>", "Save" },
    q = { "<cmd>q<cr>", "Quit" },
    e = { "<cmd>NvimTreeToggle<cr>", "Tree" },
    c = { "<cmd>bdelete<cr>", "Close Buffer" },
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
    g = {
        name = "Git",
        g = { "<cmd>lua require'neogit'.open()<cr>", "Neogit" }
    },
}, { prefix = "<leader>" });

-- harpoon
vim.keymap.set("n", "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end)


-- startup
local banner = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⠞⢛⣿⠛⠻⢦⣎⠉⠙⠲⢦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⠾⠿⠿⠶⢤⣄⡙⠻⠶⠟⠋⠀⠀⠀⢀⣈⡙⢶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⢀⠴⠊⠁⠀⠀⠀⠀⠀⠀⠀⠉⠳⢤⡀⠀⠀⠀⠀⠘⠻⣿⣶⣈⡙⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⡰⠃⠀⣠⠴⠒⠚⠉⠐⢒⡤⣀⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀⠀⣽⣯⣤⣀⡙⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⡰⠁⣠⡞⢀⡴⠛⢄⢀⡔⠋⠳⡀⠑⢄⠀⠀⠀⠙⢦⡀⠀⠀⠀⠈⠉⠉⠉⠙⠛⠿⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⢰⠃⢰⡿⠣⠋⠀⠀⠀⡅⠀⠀⠀⠙⣄⡤⢷⢄⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠓⢦⣄⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⡎⢠⣿⠁⠀⠀⠀⠀⠀⣷⣀⠀⠀⠀⠀⢄⠈⣇⢑⣄⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢦⡀⠀⠀",
    "⠀⠀⠀⠸⡇⣞⠟⣄⠀⠀⡄⠀⠀⢻⡎⢆⠀⠀⢀⡈⣦⣸⡛⡇⠳⣄⠀⠀⠀⠻⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣦⠀",
    "⠀⠀⠀⠀⣧⡟⠀⢻⣦⡄⠸⡄⠀⠘⡟⣼⡷⣞⠉⣀⡸⠈⠛⢷⠀⡈⠢⡀⠀⠀⠈⠳⣦⡀⠀⠀⠀⠀⠀⢀⣠⡤⠖⠋⠁⠀",
    "⠀⠀⠀⢸⢹⠁⢸⡀⢻⣿⣄⠹⡄⠀⢣⠙⠇⠈⣉⣠⣴⣶⣶⣾⣧⡇⠀⠹⣷⡄⠀⠀⠈⠻⣄⠤⠶⠶⠾⣿⡄⠀⠀⠀⠀⠀",
    "⠀⠀⢠⣿⠘⠀⢺⣷⠈⡟⢟⣳⡼⠒⠊⠀⠀⢠⡿⣿⠋⠉⢹⠉⡇⡇⠀⠀⠘⣿⡄⠀⠀⠀⠙⣆⠀⠀⠀⠈⢿⡀⠀⠀⠀⠀",
    "⠀⢠⣿⣿⠠⡀⠀⣿⣷⣧⣤⣭⣆⠀⠀⠀⠀⠀⠀⠹⣄⣠⠎⠀⡼⢠⠀⠀⠀⢹⣷⠀⠀⠀⠀⢸⡄⠀⠀⠀⠀⣷⠀⠀⠀⠀",
    "⢀⡿⠁⣿⢀⠇⠀⢸⣿⡿⢻⡁⢸⠇⠀⠀⠀⠀⠀⠀⠀⠀⢀⣞⣴⠃⠀⠀⠰⣸⡏⡇⠀⠀⠀⢸⡇⠀⠀⠀⠀⢿⡆⠀⠀⠀",
    "⢸⣷⣴⣿⠎⠀⠀⠀⢷⢳⡀⠛⠫⠀⠀⠀⢀⣀⡀⠴⠒⠊⠉⠁⡟⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⢸⡇⠀⠀⣠⣴⣾⡇⠀⠀⠀",
    "⠀⠀⣠⣋⡼⡄⠀⠐⢌⣿⣇⠀⠀⠀⣠⣾⠟⠛⠛⡄⠀⠀⠀⠀⡇⠀⡀⠀⡄⢹⡿⠀⠀⠀⢀⡿⣀⣶⣿⣿⣿⣿⡇⠀⠀⠀",
    "⠀⠈⠉⢹⣧⡯⡀⠀⠀⠙⢿⠒⠂⠀⠙⠧⢤⣤⠾⠃⠀⠀⠀⢠⠃⢠⡃⠀⢸⣌⡆⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⠿⠁⠀⡆⠀",
    "⠀⠀⠀⠀⣿⣿⡁⠀⢀⡇⢸⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⣀⡴⡿⠀⣾⡇⠀⣸⠛⢿⣖⣺⣿⣿⣿⣿⣿⣿⠛⠁⠀⠀⡜⠀⠀",
    "⠀⠀⠀⠀⣿⣿⡇⢀⢸⣿⣌⡟⢜⢮⣹⢶⡦⠤⣤⠾⣿⠟⣡⢃⣾⡿⢃⢀⡟⠒⠚⠛⠛⠿⢿⡿⢻⡧⣀⠑⢄⡀⣼⠀⠀⠀",
    "⠀⠀⠀⠀⠘⠿⡇⢸⡄⣿⣿⠷⡀⠙⠣⠄⢙⠞⠥⢒⣨⣭⡿⠋⡿⠁⡆⣼⠁⠀⠀⢀⡠⠔⠛⣳⣄⢣⠈⠉⠒⠛⡇⠀⡀⠁",
    "⠀⠀⠀⠀⠀⠀⣇⠈⣧⣿⠻⠷⢮⣄⣀⣀⡠⠤⣶⠞⠋⣁⣠⣴⠇⢀⣼⣿⣿⠿⠛⠛⠒⠲⣶⣻⠉⠻⣧⠀⠀⠀⣧⡜⠀⠀",
    "⠀⠀⠀⠀⠀⠀⣿⡄⢏⡇⠀⠀⢀⠜⠋⠁⣀⣶⣿⡾⣿⠿⠿⣿⣴⠿⢿⣿⠀⠀⠀⠀⠀⠀⠸⣯⠀⠀⠈⠃⠀⠀⠘⣧⠀⠀",
    "⠀⠀⠀⠀⠀⢠⡏⢃⡘⡇⠀⠀⢸⣠⣾⠟⠛⠋⢸⠃⣿⠀⢠⡿⠃⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⢹⡄⠀⠀⠀⠀⠀⠀⠈⢣⡀",
    "⠀⠀⠀⠀⢀⡜⠀⠈⠧⣥⣀⣤⣾⠟⠉⠀⠀⢀⣾⢀⣿⠀⡿⠁⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⢷⠀⠀⣀⡤⠖⠚⠋⠉⠉",
    "⠀⠀⠀⠀⠉⠀⠀⢀⣠⡞⣫⣿⠁⠀⠀⠀⠀⢠⡇⢸⣿⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⢸⡶⠞⠁⠀⠀⠀⠀⠀⠀",
}


require("startup").setup({
    parts = { "header", "body", "footer" },
    header = {
        type = "text",
        align = "center",
        title = "Header",
        margin = 5,
        content = banner,
        highlight = "Statement",
        default_color = "blue",
    },
    body = {
        type = "mapping",
        align = "center",
        fold_section = false,
        title = "Basic Commands",
        margin = 5,
        content = {
            { " Find File", "Telescope find_files", "f" },
            { " Find Text", "Telescope live_grep", "t" },
            { " Recent Files", "Telescope oldfiles", "r" },
            { " File Browser", "Explore", "b" },
            { " New Buffer", "enew", "n" },
            { " Quit", "quit", "q" },
        },
        highlight = "String",
        default_color = "",
    },
    footer = {
        type = "text",
        align = "center",
        fold_section = false,
        title = "Footer",
        margin = 5,
        content = { "Mugway's Neovim" },
        highlight = "Number",
        default_color = "",
    },
})

-- colorschemes
-- > everforest
-- options: "hard", "medium", "soft"
vim.g.everforest_background = "soft"
-- options: 0, 1
vim.g.everforest_enable_italic = 1
-- options: 0, 1, 2
vim.g.everforest_transparent_background = 1
-- > tokyonight
require("tokyonight").setup({
    style = "moon",
})
vim.cmd [[ colorscheme tokyonight ]]
