return {
    "preservim/vim-pencil",
    cmd = {
        "Pencil",
        "PencilToggle",
        "PencilHard",
        "PencilSoft",
    },
    keys = {
        { "<leader>ps", mode = { "n" }, "<cmd>PencilSoft<cr>", desc = "Pencil soft wrap" },
        { "<leader>po", mode = { "n" }, "<cmd>PencilOff<cr>", desc = "Pencil off" },
    },
    init = function()
        vim.g["pencil#wrapModeDefault"] = "soft"
    end,
}
