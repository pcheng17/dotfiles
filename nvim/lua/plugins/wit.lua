return {
    "aliqyan-21/wit.nvim",
    config = function()
        require("wit").setup({
            engine = "google", -- search engine (default: "google")
            command_search = "WitSearch", -- custom command to search (default: "WitSearch")
            command_search_visual = "WitSearchVisual", -- custom command to search visually (default: "WitSearchVisual")
            command_search_wiki = "WitSearchWiki", -- custom command to search wikipedia (default: "WitSearchWiki")
        })
    end
}
