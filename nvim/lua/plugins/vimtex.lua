return {
  "lervag/vimtex",
  lazy = true,
  dependencies = { "L3MON4D3/LuaSnip" },
  config = function()
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }

    -- PDF viewer settings
    vim.g.vimtex_view_method = "skim"

    -- Disable conceal
    vim.g.vimtex_syntax_conceal = {
      accents = 0,
      cites = 0,
      fancy = 0,
      greek = 0,
      math_bounds = 0,
      math_delimiters = 0,
      math_fracs = 0,
      math_super_sub = 0,
      math_symbols = 0,
      sections = 0,
      styles = 0,
    }
  end,
  ft = {
    "tex",
    "bib",
  },
}
