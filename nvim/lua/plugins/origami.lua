return {
	"chrisgrieser/nvim-origami",
	event = "VeryLazy",
	opts = {
        foldtext = {
            padding = 2,
            lineCount = {
                template = " ⤵ %d lines",
            }
        },
        foldKeymaps = {
            setup = false, -- modifies `h`, `l`, and `$`
        },
    }, -- needed even when using default config

	-- recommended: disable vim's auto-folding
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99

        vim.keymap.set("n", "<CR>", "za", { noremap = true, silent = true })
        vim.keymap.set("n", "$", function() require("origami").dollar() end, { noremap = true, silent = true })
	end,
}
