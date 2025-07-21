return {
    "preservim/vim-pencil",
    cmd = {
        "Pencil",
        "PencilToggle",
        "PencilHard",
        "PencilSoft",
    },
    init = function()
        vim.g["pencil#wrapModeDefault"] = "soft"
    end,
}
